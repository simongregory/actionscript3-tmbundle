#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/flex_mate' 

# A Utilty class to convert an ActionScript class into
# list of it's constituent methods and properties.
#
# As long as the src is available, and all class members
# imported directly (no wildcards), this will traverse 
# the ancestry of a class or class member storing all of
# its public and protected methods and properties.
# 
# Caveats:	A class *MUST BE FULLY* imported to be found.
# 			Use of fully qualified names is not supported, ie var foo:a.b.Klass
# 		   	#include files are not loaded and parsed.
# 			Internal classes are not supported.
# 			Code commented out may be recoginised.
#
# TODO's: -  Interfaces support mulitple extends, collect them all.
#  			 Extends regular expression - /extends(?:.|[\r\n])*?\{/
#         -  Casting support, so Sprite( thing ).member
#         -  Parse method params into snippets.
# 			 Method regexp - /\((?:.|[\r\n])*?\)/
#            Also see store_all_class_members()
#         -  Strip comments but retain newlines.
#         -  Expand wildcard imports.
#         -  Check type of return statements.
#         -  Correctly locate src directories, see create_src_list()
#
class AsClassParser
    
    private
    
	def initialize
		
		@log = ""
		@fail_log = ""
        
        #Used to track how far up the class ancestory we are.
		@depth = 0
		@type_depth = 0
		
		@src_dirs          = ""		
		@methods           = []	
		@properties        = []
		@privates          = []
		@static_properties = []
		@static_methods    = []				
		@all_members       = []

		# Captures public namespaces, tightest scope for instance.
		@pub_var_regexp    = /^\s*(public)\s+var\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		@pub_getset_regexp = /^\s*(override\s+)?(public\s+)?function\s+\b(get|set)\b\s+\b(\w+)\b\s*\(/		
		@pub_method_regexp = /^\s*(override\s+)?(public\s+)?function\s+\b([a-z]\w+)\b\s*\(/		
		
		# Protected access, looser capture includes public and protected namespaces 'super'.
		@pro_var_regexp    = /^\s*(protected|public)\s+var\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		@pro_getset_regexp = /^\s*(override\s+)?(protected|public)\s+function\s+\b(get|set)\b\s+\b(\w+)\b\s*\(/		
		@pro_method_regexp = /^\s*(override\s+)?(protected|public)\s+function\s+\b([a-z]\w+)\b\s*\(/

		@pro_static_var_regexp    = /^\s*\b(protected|public|static)\b\s+\b(protected|public|static)\b\s+\b(var|const)\b\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		@pro_static_method_regexp = /^\s*\b(protected|public|static)\b\s+\b(protected|public|static)\b\s+function\s+\b([a-z]\w+)\b\s*\(/
		@pro_static_getset_regexp = /^\s*\b(protected|public|static)\b\s+\b(protected|public|static)\b\s+function\s+\b(get|set)\b\s+([a-z]\w+)\b\s*\(/

		# Private access, the widest scope, captures all namespaces.
		@pri_var_regexp    = /^\s*(private|protected|public)\s+var\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		@pri_getset_regexp = /^\s*(override\s+)?(private|protected|public)\s+function\s+\b(get|set)\b\s+\b(\w+)\b\s*\(/		
		@pri_method_regexp = /^\s*(override\s+)?(private|protected|public)\s+function\s+\b([a-z]\w+)\b\s*\((.*\)\s*:\s*(\w+))?/
		
		@constructor_regexp = /^\s*public\s+function\s+\b([A-Z]\w+)\b\s*\(/
		
		#@pri_method_regexp_multiline = /^\s*(override\s+)?(private|protected|public)\s+function\s+\b([a-z]\w+)\b\s*\((?m:[^)]+)\)\s*:\s*(\w+)/

		@pri_static_var_regexp    = /^\s*\b(private|protected|public|static)\b\s+\b(private|protected|public|static)\b\s+\b(var|const)\b\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		@pri_static_method_regexp = /^\s*\b(private|protected|public|static)\b\s+\b(private|protected|public|static)\b\s+function\s+\b([a-z]\w+)\b\s*\(/
		@pri_static_getset_regexp = /^\s*\b(private|protected|public|static)\b\s+\b(private|protected|public|static)\b\s+function\s+\b(get|set)\b\s+([a-z]\w+)\b\s*\(/
								
		# Captures public class level members
		@pub_static_var_regexp = /^\s*\b(public|static)\b\s+\b(static|public)\b\s+\b(var|const)\b\s+\b(\w+)\b\s*:\s*((\w+)|\*)/		
		@pub_static_method_regexp = /^\s*(public|static)\s+(static|public)\s+function\s+\b([a-z]\w+)\b\s*\(/
		@pub_static_getset_regexp = /^\s*(public|static)\s+(static|public)\s+function\s+\b(get|set)\b\s+\b([a-z]\w+)\b\s*\(/
		
		#Type detection captures.
		@extends_regexp = /^\s*(public)\s+(dynamic\s+)?(final\s+)?(class|interface)\s+(\w+)\s+(extends)\s+(\w+)/
		@private_class_regexp = /^class\b/
		
		create_src_list()
		
    end
    
	# Property/Method Capture.
	
	# Storage caputure filters based on the scope of the
	# item being processed. So, for 'this' all memebers and scopes,
	# for an instance of ClassFoo it's public members.
		
	def store_all_class_members(doc)

		return if doc == nil

		log_append( "Adding level " + @depth.to_s )
		
		# method_scans = []
		
		doc.each do |line|
			
			if line =~ @pri_var_regexp
		  		@properties << $2.to_s  
			elsif line =~ @pri_method_regexp
				
				@methods << $3.to_s + "()"
				
				# Based off the the $4 th match we can determine wheter or not the
				# method prams are mulit-line or not. If they are we need to come
				# back and search again.
				#if $4 == nil
				#	method_scans << $3.to_s
				#else
				#	@methods << $3.to_s + "():" + $5.to_s
				#end
				#method_scans << $3.to_s
				
			elsif line =~ @pri_getset_regexp
			    @properties << $4.to_s
			elsif line =~ @pri_static_getset_regexp
			    @properties << $4.to_s			
			elsif line =~ @pri_static_method_regexp
			    @static_methods << $3.to_s			    
			elsif line =~ @pri_static_var_regexp
			    @static_properties << $4.to_s			    
		    elsif line =~ @private_class_regexp
		        break
			end
			
		end
		
		# method_scans.each do |meth|
		# 	method_multiline = /^\s*(override\s+)?(private|protected|public)\s+function\s+\b#{meth}\b\s*\((?m:[^)]+)\)\s*:\s*(\w+)/
		# 	doc.scan( method_multiline )
		# 	if $2 != nil
		# 		@methods <<  "#{meth}(): #{$3}"
		# 	end
		# end
		
		@depth += 1
		
	end
	
	def store_public_and_protected_class_members(doc)
	    
	    return if doc == nil

		log_append( "Adding level " + @depth.to_s )

		doc.each do |line|
			
			if line =~ @pro_var_regexp
		  		@properties << $2.to_s  
			elsif line =~ @pro_method_regexp				
			    @methods << $3.to_s + "()" 
			elsif line =~ @pro_getset_regexp
			    @properties << $4.to_s
			elsif line =~ @pro_static_getset_regexp
			    @static_methods << $4.to_s			    
			elsif line =~ @pro_static_method_regexp
			    @static_methods << $3.to_s			    
			elsif line =~ @pro_static_var_regexp
			    @static_properties << $4.to_s			    			    
		    elsif line =~ @private_class_regexp
		        break
			end
			
		end
		
		@depth += 1
		
    end
	
	def store_public_class_members(doc)

		return if doc == nil

		log_append( "Adding level " + @depth.to_s )
		
		doc.each do |line|
			
			if line =~ @pub_var_regexp
		  		@properties << $2.to_s  
			elsif line =~ @pub_getset_regexp
			    @properties << $4.to_s
			elsif line =~ @pub_method_regexp
			    @methods << $3.to_s + "()"
		    elsif line =~ @private_class_regexp
		        break
			end
			
		end
		
		@depth += 1
		
	end
	
	def store_static_members(doc)
		
		return if doc == nil
		
		doc.each do |line|
			
			if line =~ @pub_static_var_regexp
		  		@static_properties << $4.to_s  
			elsif line =~ @pub_static_getset_regexp
			    @static_properties << $4.to_s
			elsif line =~ @pub_static_method_regexp
			    @static_methods << $3.to_s + "()"
            elsif line =~ @private_class_regexp
                break    		    
			end
			
		end
		
	end
	
	# UI Menu Utilities.
	
	# Add items to full list of captured class members.
	# Constructs a list by adding 
	def add_to_all_members(items_to_add)
	    return if items_to_add == nil
	    if items_to_add.size > 0
	        @all_members.push('-') if @all_members.size > 0
	        @all_members = @all_members + items_to_add
	    end
	end
	
	# Document Loaders.
	
	# Loads and returns the superclass of the supplied doc.	
	def load_parent(doc)

		# Scan evidence of a superclass.
		doc.scan(@extends_regexp)
		
		if $4 == "interface"					
			log_append( "WARNING: Interfaces with more than one ancestor are not supported." )
		end
		
		# If we match then convert the import to a file reference.
		if $7 != nil
			parent_path = imported_class_to_file_path(doc,$7)
			log_append("Loading super class '#{$7}' '#{parent_path}'.")
			return load_class( parent_path )
		end
		
		return nil
	end
	
	# Adds all class members to our lists.
 	def add_doc(doc)
		
		return if doc == nil
		
		store_all_class_members(doc)

		next_doc = load_parent(doc)

		# Start recursing superclasses.
		add_public_and_protected(next_doc)
		
 	end
 	
	# Adds all public and protected methods and properties to our lists.
 	def add_public_and_protected(doc)
 	    
 	    return if doc == nil
		
		store_public_and_protected_class_members(doc)

		next_doc = load_parent(doc)
		add_public_and_protected(next_doc)
		
    end
	
	# Adds all public instance methods and properties to our lists.
 	def add_public(doc)
		
		return if doc == nil
		
		store_public_class_members(doc)

		next_doc = load_parent(doc)
		add_public(next_doc)
		
 	end
	
	# Path finding.
	
	# Collects all of the src directories into a list.
    # The resulting list of dirs is then used when 
	# locating source files.
	def create_src_list
		
		if ENV['TM_PROJECT_DIRECTORY']
			@src_dirs = `find "$TM_PROJECT_DIRECTORY" -maxdepth 5 -name "src" -print`			
		end

		bun_sup = "#{ENV['TM_BUNDLE_SUPPORT']}/data/completions"
		
		# Check once for existence here as we will save repeated 
		# checks later (whilst walking up the heirarchy).
		@src_dirs += "#{bun_sup}/intrinsic\n" if File.directory?("#{bun_sup}/intrinsic")
		@src_dirs += "#{bun_sup}/frameworks/air\n" if File.directory?("#{bun_sup}/frameworks/air")
		@src_dirs += "#{bun_sup}/frameworks/flash_ide\n" if File.directory?("#{bun_sup}/frameworks/flash_ide")
		@src_dirs += "#{bun_sup}/frameworks/flash_cs3\n" if File.directory?("#{bun_sup}/frameworks/flash_cs3")
		
		# Where we have access to the compressed flex 3 files use them, 
		# otherwise go looking for the sdk.
		if File.directory?("#{bun_sup}/frameworks/flex_3")
			@src_dirs += "#{bun_sup}/frameworks/flex_3\n"
		else		
			fx = FlexMate.find_sdk_src
			@src_dirs += fx if fx != nil
		end
		
 	end
			
	# Finds the class in the filesystem.
	# If successful the class is loaded and returned.
	# paths is an array of relative class paths.
	def load_class(paths)
		
		@src_dirs.each do |d|

			paths.each do |path|
				
				uri = d.chomp + "/" + path.chomp
				#FIX: The assumption that we'll only find one match.
				if File.exists?(uri)
					log_append("Opening #{uri}.")
					f = File.open(uri,"r" ).read.strip
					return strip_comments(f)
				end
				
			end
			
		end
		
		as_file = File.basename(paths[0])
		
		@fail_log = "#{as_file} 404."
		
		log_append("Unable to load #{as_file}")
		
		nil
	end
	
	# Remove all comments from the file.
	def strip_comments(doc)

		# TODO: Add multiline_comments, remembering that they need 
		# replacing with whitespace otherwise we can't track our 
		# position within the doc when searching - ie for local vars.
		
		#multiline_comments = /\/\*(?:.|[\r\n])*?\*\//
		#doc = doc.gsub(multiline_comments,'')		
		
		single_line_comments = /\/\/.*$/		
		return doc.gsub(single_line_comments,'')
		
	end

	# Searches the given document for the import statement
	# of the specified class, if located it returns it
	# as file path reference.
	# If no explicit import is delared wildcarded imports are accumulated,
	# alongside the classes package patch and returned.
	# Returns an array of possible file paths.
	def imported_class_to_file_path(doc,class_name)
		
		possible_paths = []
		
		# Check for explicit import statement.
        doc.scan( /^\s*import\s+(([\w+\.]+)(\b#{class_name}\b))/)

		unless $1 == nil
			p = $1.gsub(".","/")+".as"
			log_append("Class found as import '#{p}'")
        	return possible_paths << p
		end
		
		pckg = /^\s*package\s+([\w+\.]+)/
		cls = /^\s*(public|final)\s+(final|public)?\s*\bclass\b/
		wild = /^\s*import\s*([\w.]+)\*/

		# Collect all wildcard imports here.
		doc.each do |line|
		 	possible_paths << $1.gsub(".","/")+class_name+".as" if line =~ wild
			possible_paths << $1.gsub(".","/")+"/"+class_name+".as" if line =~ pckg
			break if line =~ cls
		end

		# As we are very likely to have a package path by this point 
		# add in a top level match for safetys sake.
		return possible_paths << "#{class_name}.as"
		
	end
	
	# Type Locating Commands
	
	# Searches a document for the type of the specified property.
	# Returns an array. First element being the document that contains the ref. 
	# 					Second element being the type of the reference.
	def determine_type_globally(doc,reference)
		
		return if doc == nil
		
		#TODO: This is still using the original scope (expecting to start on 
		# 	   'this') so doesn't only collect public vars when it should. 
		log_append("FIX THIS>")
		
		namespace = "protected|public"
		namespace = "private|protected|public" if @type_depth == 0

		# TODO: Should this be global? So it's not created on each recursion.
		# 		Method paramaeters are likely to need work for the accessor.
		var_regexp = /^\s*(#{namespace})\s+var\s+\b(#{reference})\b\s*:\s*((\w+)|\*)/

		# Also picks up single line methods.
		get_regexp = /^\s*(#{namespace})\s+function\s+(\b(get)\b\s+)?\b(#{reference})\b\s*\(.*\)\s*:\s*((\w+)|\*)/
				 
		doc.scan(var_regexp)		
		if $3 != nil
		    log_append("Type determined as '#{$3}' in global scope.")
		    return [doc,$3]
	    end
	
		doc.scan(get_regexp)		
		if $6 != nil
			if $6 == "void"
				@fail_log = "void"
				return nil
			end
		    log_append("Type determined as '#{$6}' in global scope.")
		    return [doc,$6]
	    end

		@type_depth += 1
		
		# Try the superclass.
		next_doc = load_parent(doc);
		determine_type_globally(next_doc,reference);
		
	end

	# Searches the local scope for a var declaration
	# Returns an array. First element being the document that contains the ref. 
	# 					Second element being the type of the reference.
	#
	# TODO: As this makes the assumption that we're 
	# 		within a method. Which is in no way guaranteed.	
	def determine_type_locally(doc,reference)
		
		# Conditionals may cause problems...
		type_regexp = /\s*(\b#{reference}\b)\s*:\s*(\w+)/		
		
		if doc == nil
			log_append( "No doc for #{reference} !" )
			return
		end
		
		d = doc.split("\n")
		ln = ENV['TM_LINE_NUMBER'].to_i-1

		while ln > 0

		    txt = d[ln].to_s
		
			if txt =~ type_regexp

				log_append( "Type locally matched as \n\t#{txt}." )
				
				return [doc,$2]
				
			elsif txt =~ @pri_method_regexp
				
				# When we hit a method statement exit.
				log_append( "Type not located locally." )
				return nil
				
			elsif txt =~ @constructor_regexp
				
				# When we hit a (conventional) constructor statement exit.
				log_append( "Type not located locally." )
				return nil
				
			end
			
		    ln -= 1

		end
		
		log_append("Type locally failed!? (We should not get this far).")
		return nil
	end
	
	# Searches both the local and global scopes for the type.
	def determine_type_all(doc,reference)

		type = determine_type_locally(doc,reference)
		type = determine_type_globally(doc,reference) if type == nil
		
		return type		
		
	end
	
	# Utility method for search_ancestor which uses the level to 
	# track the depth of recursion, if it's 0 then we are operating
	# at a local level.
	def determine_type_at_level(doc,reference,depth)
		return determine_type_all(doc,reference) if depth == 0
		return determine_type_globally(doc,reference)
	end
	
	# Moves to the superclass of the class doc, if there is one.
	# doc is the current class document.
	# items is an array of properties to check - ie, propA.propB.propC
	def search_ancestor(doc,items,depth=0)
		
		find_type = items.shift
		
		if find_type =~ /(\s*(\w+\s*)?)\(.*\)/
			log_append("Stripped method call #{$1} #{find_type}")
			find_type = $1
		end
		
		if items.size == 0
									
			# Reached the last item in the list.
			type = determine_type_at_level(doc,find_type,depth)
			
			return nil if type == nil
			
			log_append("Located "+ find_type + " as #{type[1]} ")
			
			return type
			
		else
			
			log_append("Finding "+ find_type)
			
			# Recurse down.
			type = determine_type_at_level(doc,find_type,depth)
			
			return nil if type == nil

			path = imported_class_to_file_path(type[0],type[1])
			
			log_append("Found '#{find_type}' here '#{path.join(", ")}'")
			
			child_doc = load_class(path)
				
			return search_ancestor(child_doc,items, depth+=1)
			
		end
		
	end
	
	# As it says on the tin...
	def log_append(message)
		@log += message + "\n"
	end
    	
    public
    
	# String to show in tooltip when the parsing has failed.
	def fail_log
		@fail_log
	end
    
	# Input Commands
	
    # Loads a full instance or class level member list for the class
	# document using the reference to determine the type of the class.
    def load(doc,reference)
		
		# Set our depth counters to defaults.
        @depth = 0
		@type_depth = 0
		
		doc = strip_comments(doc)        
	
		# Class Members.
		if reference =~ /^([A-Z]|\b(uint|int|arguments)\b)/
			
			# TODO: don't match new ClassName(), pass these down as instances.
			#       ie var a:Foo = new Foo().name;
			
			path = imported_class_to_file_path(doc,reference)
			log_append( "Processing #{reference} as static. #{path}" )
			store_static_members( load_class(path) )

		# Super Instance Members.
		elsif reference =~ /^super$/

			log_append("Processing #{reference} as a super class.")			
			super_class = load_parent(doc)
			@depth = 1
			add_public_and_protected(super_class)

		# This Instance Members.
		elsif reference =~ /^(this)?$/

            log_append("Processing as '#{reference}'.")
			add_doc(doc)            
            
		# Instance Members.
		else
			
            log_append("Processing '#{reference}' as an instance.")
            
			type = determine_type(doc,reference)
			
			if type != nil

				path = imported_class_to_file_path(type[0],type[1])
				cdoc = load_class(path)
				add_public(cdoc) if cdoc != nil
								
			else
				
			    log_append("Failed to locate type of '#{reference}'.")
			
			end
			
		end
		
		# TODO: Check type of method return statements.
		
    end
	
	# Attempts to find the type of the reference within the doc.
	def determine_type(doc,reference)
		
		# Class Members.
		if reference =~ /^([A-Z]|\b(uint|int)\b)/

			return [doc, reference]
			
		# Super Instance Members.
		elsif reference =~ /^super$/
			
			# Scan evidence of a superclass.
			doc.scan(@extends_regexp)
			return [doc, $7] if $7 != nil

		# 'this' instance members.
		elsif reference =~ /^(this)?$/
            
			# Locate class name.			
			doc.scan(/^\s*(\b(public|dynamic|final)+)\s+(class|interface)\s+(\w+)\s+/)			
			return [doc, $4] if $4 != nil
            
		# Instance Members.
		else
			            
            log_append("Determining type of '#{reference}'.")
            
			items = [reference]
			
			cl = ENV['TM_CURRENT_LINE']
			if /\s+(\b.*\.\b#{reference}\b)/ =~ cl												
				items = $1.split(".")
			end			
			log_append("Ancestor list: "+items.join(", "))
			return search_ancestor(doc,items)
			
		end
		
	end
	
	# As determine_type, but only returns the member type.
	def find_type(doc,reference)
		type = determine_type(doc,reference)
		return type[1].to_s if type != nil
		return nil
	end
	
    # Ouput Commands
    
	# List of method names.
    def methods
        
        return if @methods.empty?
        @methods.uniq.sort
        
    end
	
	# List of property names.
	def properties
				
		return if @properties.empty?
		@properties.uniq.sort
		
	end
	
	# List of static property names.
	def static_properties
        return if @static_properties.empty?
		@static_properties.uniq.sort		
	end
	
	# List of static method names.
	def static_methods
       return if @static_methods.empty?	    
	   @static_methods.uniq.sort
	end
	
	# Full list of all class and superclass methods.
	def members
		@all_members = []		
		add_to_all_members(properties)
		add_to_all_members(methods)
		add_to_all_members(static_properties)
		add_to_all_members(static_methods)
		return @all_members
	end
	
	# String of log messages.
	def log
		@log
	end
	
	# Print log to the system log file.
	def to_syslog
		
		require 'syslog'
        
		Syslog.open('tm-as3')
		Syslog.crit('-->')
		@log.split("\n").each do |line|
			Syslog.crit(line)
		end
		Syslog.crit('<--')
		Syslog.close()
		
	end

end
