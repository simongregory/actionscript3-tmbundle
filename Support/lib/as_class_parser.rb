# A Utilty class to convert an ActionScript class into
# list of it's constituent methods and properties.
#
# As long as the src is available, and all class members
# imported directly (no wildcards), this will traverse 
# the ancestry of a class or class member storing all of
# its public and protected methods and properties.
# 
# Caveats:	A class MUST be FULLY imported to be found.
# 			Use of fully qualified names is not supported. 
# 				ie var foo:org.this.ThatClass
# 		   	include files are not supported.
# 			Internal classes are not supported.
# 			
class AsClassParser
    
    private
    
	def initialize
		
		@log = ""
        
        #Used to track how far up the class ancestory we are.
		@depth = 0
		@type_depth = 0
		
		@src_dirs          = []		
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
		@pro_static_method_regexp = /^\s*\b(protected|public)\s+(static\s+)function\s+\b([a-z]\w+)\b\s*\(/

		# Private access, the widest scope, captures all namespaces.
		@pri_var_regexp    = /^\s*(private|protected|public)\s+var\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		@pri_getset_regexp = /^\s*(override\s+)?(private|protected|public)\s+function\s+\b(get|set)\b\s+\b(\w+)\b\s*\(/		
		@pri_method_regexp = /^\s*(override\s+)?(private|protected|public)\s+function\s+\b([a-z]\w+)\b\s*\((.*\)\s*:\s*(\w+))?/

		#@pri_method_regexp_multiline = /^\s*(override\s+)?(private|protected|public)\s+function\s+\b([a-z]\w+)\b\s*\((?m:[^)]+)\)\s*:\s*(\w+)/

		@pri_static_var_regexp    = /^\s*\b(private|protected|public|static)\b\s+\b(private|protected|public|static)\b\s+\b(var|const)\b\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		@pri_static_method_regexp = /^\s*\b(private|protected|public)\s+(static\s+)function\s+\b([a-z]\w+)\b\s*\(/
								
		# Captures public class level members
        # TODO: Add Accessors.
		@static_method = /^\s*(public)\s+(static\s+)function\s+\b([a-z]\w+)\b\s*\(/
		@const_regexp = /^\s*\b(public|static)\b\s+\b(static|public)\b\s+\b(var|const)\b\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		
		#Type detection captures.
		@extends_regexp = /^\s*(public)\s+(dynamic\s+)?(final\s+)?(class|interface)\s+(\w+)\s+(extends)\s+(\w+)/		
		@private_class_regexp = /^class\b/
		
		create_src_list()
		
    end
    
	# Property/Method Capture.
	# Storage caputure filters based on the percieved scope of the
	# item being processed. So, for 'this' all memebers and scopes,
	# for an instance of ClassFoo it's public members.
		
	def store_all_class_members(doc)

		return if doc == nil

		@log += "Adding level " + @depth.to_s + "\n"
		
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

		@log += "Adding level " + @depth.to_s + "\n"

		doc.each do |line|
			
			if line =~ @pro_var_regexp
		  		@properties << $2.to_s  
			elsif line =~ @pro_method_regexp				
			    @methods << $3.to_s + "()" 
			elsif line =~ @pro_getset_regexp
			    @properties << $4.to_s
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

		@log += "Adding level " + @depth.to_s + "\n"
		
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
			
			if line =~ @const_regexp
		  		@static_properties << $4.to_s  
			elsif line =~ @static_method
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
		
		# If we match then convert the import to a file reference.
		if $7 != nil
			parent_path = imported_class_to_file_path(doc,$7)
			@log += "Loading super class #{$7} #{parent_path}.\n"
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
		
		@src_dirs = `find "$TM_PROJECT_DIRECTORY" -maxdepth 5 -name "src" -print`
		@src_dirs += "#{ENV['TM_BUNDLE_SUPPORT']}/data/src\n"

		#TODO: Move to utility.
		flx = [ "#{ENV['TM_FLEX_PATH']}/frameworks/project/framework/src",
				"#{ENV['TM_FLEX_PATH']}/framework/src",
			    "/Applications/flex_sdk_3/frameworks/project/framework/src",
		        "/Applications/flex_sdk_2/frameworks/source",
		        "/Developer/SDKs/flex_sdk_3/frameworks/project/framework/src",
		        "/Developer/SDKs/flex_sdk_2/frameworks/source" ]
		
		fx = flx.find { |dir| File.directory? dir }
		
		@src_dirs += fx if fx != nil
		
 	end
			
	# Finds the class in the filesystem.
	# If successful the class is loaded and returned.
	def load_class(path)
		@src_dirs.each { |d|
			uri = d.chomp + "/" + path
			#@log += "Testing #{uri}.\n"
			#FIX: The assumption that we'll only find one match.
			if File.exists?(uri)
				@log += "Opening #{uri}.\n"
				f = File.open(uri,"r" ).read.strip
				return strip_comments(f)
			end
		}
		nil
	end
	
	# Remove all comments from the file.
	def strip_comments(doc)
		# TODO: Add multiline_comments, remembering that they need 
		# replacing with whitespace otherwise we can't track our 
		# position within the doc when searching.
		# multiline_comments = /\/\*(?:.|[\r\n])*?\*\//
		single_line_comments = /\/\/.*$/		
		return doc.gsub(single_line_comments,'')
	end

	# Searches the given document for the import statement
	# of the specified class, when located it returns it
	# as file path reference.
	# NOTE: This relies on the Class being imported.
	# TODO: Add support for wildcarded imports.	
	# 		Do this by expanding/loading all the classes in package?
    # 		ie import flash.net.*;    
	def imported_class_to_file_path(doc,class_name)

		# Use import statment to find our doc.
        doc.scan( /^\s*import\s+(([\w+\.]+)(\b#{class_name}\b))/)
        
        return $1.gsub(".","/")+".as" if $1 != nil

		# Assume it's top level.
		return class_name + ".as"
		
	end
	
	# Type Locating Commands
	
	# Searches a document for the type of the specified property.
	def determine_type_globally(doc,reference)
		
		return if doc == nil

		namespace = "protected|public"
		namespace = "private|protected|public" if @type_depth == 0

		# TODO: Should this be global? So it's not created on each recursion.
		# 		Method paramaeters are likely to need work for the accessor.
		var_regexp = /^\s*(#{namespace})\s+var\s+\b(#{reference})\b\s*:\s*((\w+)|\*)/
		gs_regexp = /^\s*(#{namespace})\s+function\s+\b(get|set)\b\s+\b(#{reference})\b\s*\(.*\)\s*:\s*((\w+)|\*)/
		 
		doc.scan(var_regexp)		
		if $3 != nil
		    @log += "Determined Type as #{$3}.\n"
		    return $3
	    end
	
		doc.scan(gs_regexp)		
		if $5 != nil
		    @log += "Determined Type as #{$5}.\n"
		    return $5
	    end

		@type_depth += 1
		
		# Try the superclass.
		next_doc = load_parent(doc);
		determine_type_globally(next_doc,reference);
		
	end

	# Searches the local scope for a var declaration
	# and returns it's type if found.
	# TODO: As this makes the assumption that we're 
	# 		within a method. Which is in no way guaranteed.
	def determine_type_locally(doc,reference)
		
		# Conditionals may cause problems...
		type_regexp = /\s*(\b#{reference}\b)\s*:\s*(\w+)/		
		
		if doc == nil
			@log += "No doc for #{reference} !"
			return
		end
		
		d = doc.split("\n")
		ln = ENV['TM_LINE_NUMBER'].to_i-1

		while ln > 0

		    txt = d[ln].to_s
		
			if txt =~ type_regexp

				@log += "Type locally matched as \n\t#{txt}."
				
				return $2
				
			elsif txt =~ @pri_method_regexp
				
				#When we hit a method statement exit.
				@log += "Type not located locally.\n"
				return nil
				
			end
			
		    ln -= 1

		end
		
		@log += "Type locally failed!? (We shoudn't get this far).\n"
		return nil
	end

	def determine_type_all(doc,reference)

		type = determine_type_locally(doc,reference)
		type = determine_type_globally(doc,reference) if type == nil
		
		return type		
		
	end
	
	def next_ancestor(doc,items)
		
		find_type = items.shift
				
		if items.size == 0
						
			# We're on the home stretch.
			type = determine_type_all(doc,find_type)
			@log += "\nLocated "+ find_type + " as #{type} \n"
			
			return nil if type == nil
			return [doc,type]
			
		else
			
			@log += "\nFinding "+ find_type + "\n"
			# Do another turn.
			type 	  = determine_type_all(doc,find_type)
			path 	  = imported_class_to_file_path(doc,type)
			child_doc = load_class(path)
			
			return next_ancestor(child_doc,items)
			
		end
		
	end
    	
    public
    
	# Input Commands
	
    # Loads a full instance or class level member list for the class
	# document using the reference to determine the type of the class.
    def load(doc,reference)
		
		# Set our depth counters to defaults.
        @depth = 0
		@type_depth = 0
		
		doc = strip_comments(doc)        
	
		# Class Members.
		if reference =~ /^([A-Z]|\b(uint|int)\b)/
			# TODO: don't match new ClassName(), pass these down as instances.			
			path = imported_class_to_file_path(doc,reference)
			@log += "Processing #{reference} as static. #{path}\n"
			store_static_members( load_class(path) )

		# Super Instance Members.
		elsif reference =~ /^super$/
			
			super_class = load_parent(doc)
			@log += "Processing #{reference} as super class.\n"
			@depth = 1
			add_doc(super_class)

		# This Instance Members.
		elsif reference =~ /^(this)?$/

            @log += "Processing as #{reference}.\n"
			add_doc(doc)            
            
		# Instance Members.
		else
			
            @log += "Processing #{reference} as an instance.\n"
            
			type = determine_type(doc,reference)
			
			if type != nil
				
				@log += "> #{type[1]} located.\n"
				path = imported_class_to_file_path(type[0],type[1])
				cdoc = load_class(path)
				add_public(cdoc) if cdoc != nil
								
			else
				
			    @log += "Failed to locate type of #{reference}.\n"
			
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

		# This Instance Members.
		elsif reference =~ /^(this)?$/
            
			# Locate class name.			
			doc.scan(/^\s*(\b(public|dynamic|final)+)\s+(class|interface)\s+(\w+)\s+/)			
			return [doc, $4] if $4 != nil
            
		# Instance Members.
		else
			            
            @log += "Determining type of #{reference}.\n"
            
			items = [reference]
			
			cl = ENV['TM_CURRENT_LINE']
			if /\s+(\b.*\.\b#{reference}\b)/ =~ cl												
				items = $1.split(".")
			end
			
			return next_ancestor(doc,items)
			
		end
		
	end
	
	# As determine_type, but only returns the member type.
	def find_type(doc,reference)
		type = determine_type(doc,reference)
		return type[1].to_s if type != nil
		return nil
	end
	
    # Ouput Commands
    
    def methods
        
        return if @methods.empty?
        @methods.uniq.sort
        
    end
	
	def properties
				
		return if @properties.empty?
		@properties.uniq.sort
		
	end
		
	def static_properties
        return if @static_properties.empty?
		@static_properties.uniq.sort		
	end
	
	def static_methods
       return if @static_methods.empty?	    
	   @static_methods.uniq.sort
	end
	
	def log
		@log
	end
	
	def members
		@all_members = []		
		add_to_all_members(properties)
		add_to_all_members(methods)
		add_to_all_members(static_properties)
		add_to_all_members(static_methods)
		return @all_members
	end

end
