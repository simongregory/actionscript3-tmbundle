#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/flex_mate'

# A Utilty class to convert an ActionScript class into
# list of it's constituent methods and properties.
#
# As long as the source is available this will traverse
# the ancestry of a class or class member storing all of
# its public and protected methods and properties.
#
# Caveats:  Use of fully qualified names is not supported, ie var foo:a.b.Klass
#           #include files are not loaded and parsed.
#           Internal classes are not supported.
#
# TODO's: - Multiline static methods.
#         - Check type of return statements.
#         - Stoping local vars in other scopes from being picked up.
#
class AsClassParser
	
	private

	def initialize

		@log = ""
		@exit_message = ""

		#Used to track how far up the class ancestory we are.
		@depth = 0
		@type_depth = 0

		#Void return type for inspected item.
		@return_type_void = false
		
		@completion_src = ENV['TM_BUNDLE_SUPPORT']
		
		#Parse class meta data alongside methods and properties (for flex tags).
		@include_metadata = false

		@src_dirs          = ""
		@methods           = []
		@properties        = []
		@getsets           = []		
		@privates          = []
		@static_properties = []
		@static_methods    = []
		@effects					 = []
		@events            = []
		@styles            = []
		@all_members       = []
		@loaded_documents  = []
		
		@mbr =[]

		@pub = AsClassRegex.new("public")
		@pro = AsClassRegex.new("protected|public")
		@pri = AsClassRegex.new("private|protected|public")

		@pub_stat = AsClassRegex.new("public|static")
		@pro_stat = AsClassRegex.new("protected|public|static")
		@pri_stat = AsClassRegex.new("private|protected|public|static")
		
		@i_face = AsInterfaceRegex.new()

		# Type detection captures.		
		@extends_regexp = /^\s*((dynamic|final)\s+)?(public)\s+((dynamic|final)\s+)?(class|interface)\s+(\w+)\s+(extends)\s+(\w+)/
		@interface_regexp = /^\s*public\s+(interface)\s+(\w+)\b/
		@interface_extends_regexp = /^\s*(public)\s+(dynamic\s+)?(final\s+)?(class|interface)\s+(\w+)\s+(extends)\s+\b((?m:.*))\{/ #}
		@private_class_regexp = /^class\b/
		
		@static_member_regexp = /^([A-Z]\w*|\b(uint|int|arguments)\b)$/

		# Constructors.
		@constructor_regexp = /^\s*public\s+function\s+\b([A-Z]\w+)\b\s*\(/

		#@method_regexp_multiline = /^\s*(override\s+)?(private|protected|public)\s+function\s+\b([a-z]\w+)\b\s*\((?m:[^)]+)\)\s*:\s*(\w+)/

		create_src_list()

	end

	# ===============================
	# = Property and Method Capture =
	# ===============================

	# Storage caputure filters based on the scope of the
	# item being processed. So, for 'this' all memebers and scopes,
	# for an instance of FooClass it's public members.

	def store_all_class_members(doc)

		return if doc.nil?
		
		store_local_scope(doc)
		
		log_append( "Adding local (ppp)" + @depth.to_s )

		method_scans = []

		doc.each do |line|

			if line =~ @pri.vars
		  		@properties << $2.to_s
			elsif line =~ @pri.methods

				# Based off the the $7 th match we can determine wheter or not the
				# method prams are mulit-line or not. If they are we need to store
				# the method name and use a scan search after we have been through
				# line by line.
				
				if $7 != nil and $4 != nil
					# Single line methods - terminated with return statement.
					@methods << "#{$3.to_s}(#{$4.to_s}):#{$7.to_s}"
				else
					method_scans << $3
				end

			elsif line =~ @pri.getsets
			    #@properties << $4.to_s
				@getsets << $4.to_s
			elsif line =~ @pri_stat.getsets
			    @properties << $4.to_s
			elsif line =~ @pri_stat.methods
			    @static_methods << "#{$3.to_s}()"
			elsif line =~ @pri_stat.vars
			    @static_properties << $4.to_s
		  elsif line =~ @private_class_regexp
		        break
			end

		end
		
		store_multiline_methods(doc,method_scans,"private|protected|public")

		@depth += 1

	end
	
	def store_local_scope(doc)
		
		return unless ENV['TM_SCOPE'] =~ /meta\.function\.actionscript\.3/
		
		# Collect all memebers between the current line and a method definition.
		props = []
		
		# TODO: Conditionals may cause problems because of the colon.
		type_regexp = /\s*(\b\w+\b)\s*:\s*(\w+)/

		d = doc.split("\n")
		ln = ENV['TM_LINE_NUMBER'].to_i-1

		while ln > 0

			txt = d[ln].to_s

			props << $1 if txt =~ type_regexp
			
			break if txt =~ @pri.methods				
			break if txt =~ @constructor_regexp

			ln -= 1

		end

		return nil if ln == 0
		
		@properties.concat(props)
		
	end
	
	def store_multiline_methods(doc,method_refs,ns)
		method_refs.each do |meth|
			method_multiline = /^\s*(override\s+)?(#{ns})\s+function\s+\b#{meth}\b\s*\(((?m:[^)]+))\)\s*:\s*(\w+)/
			doc.scan( method_multiline )
			if $2 != nil				
				if $3 != nil					
					params = $3.gsub(/(\s|\n)/,"")
					@methods << "#{meth}(#{params}):#{$4}"
				else
					@methods << "#{meth}():#{$4}"
				end
			end
		end		
	end
	
	def store_multiline_interface_methods(doc,method_refs)
		method_refs.each do |meth|
			method_multiline = /^\s*function\s+\b#{meth}\b\s*\(((?m:[^)]+))\)\s*:\s*(\w+)/
			doc.scan( method_multiline )
			if $2 != nil				
				if $1 != nil					
					params = $1.gsub(/(\s|\n)/,"")
					@methods << "#{meth}(#{params}):#{$2}"
				else
					@methods << "#{meth}():#{$2}"
				end
			end
		end		
	end

	def store_public_and_protected_class_members(doc)

		return if doc.nil?

		log_append( "Adding ancestor (pp) " + @depth.to_s )
		
		method_scans = []
		
		doc.each do |line|
			
			if line =~ @pro.vars

				@properties << $2.to_s
				
			elsif line =~ @pro.methods
				
				if $7 != nil and $4 != nil
					# Single line methods - terminated with return statement.
					@methods << "#{$3.to_s}(#{$4.to_s}):#{$7.to_s}"
				else
					method_scans << $3
				end
			 
			elsif line =~ @pro.getsets
				@getsets << $4.to_s
			elsif line =~ @pro_stat.getsets
				@static_methods << $4.to_s
			elsif line =~ @pro_stat.methods
				@static_methods << "#{$3.to_s}()"
			elsif line =~ @pro_stat.vars
				@static_properties << $4.to_s
		  elsif line =~ @private_class_regexp
				break
			end


		end
		
		store_multiline_methods(doc,method_scans,"protected|public")
		
		@depth += 1

	end

	def store_public_class_members(doc)

		return if doc.nil?

		log_append( "Adding ancestor (p) " + @depth.to_s )
		method_scans = []
		
		doc.each do |line|
			
			if @include_metadata
				if line =~ @pub.effects
					@effects << $1.to_s
					next
				elsif line =~ @pub.events
					@events << $1.to_s
					next
				elsif line =~ @pub.styles
					@styles << $1.to_s
					next
				end
			end

			if line =~ @pub.vars
				@properties << $2.to_s
			elsif line =~ @pub.getsets
				@getsets << $4.to_s
			elsif line =~ @pub.methods
				if $7 != nil and $4 != nil
					@methods << "#{$3.to_s}(#{$4.to_s}):#{$7.to_s}"
				else
					method_scans << $3
				end
			elsif line =~ @private_class_regexp
				break
			end

		end
		
		store_multiline_methods(doc,method_scans,"protected|public")
		
		@depth += 1

	end

	def store_interface_members(doc)

		return if doc.nil?

		log_append( "Adding ancestor (i) " + @depth.to_s )
		
		method_scans = []
		doc.each do |line|

			if line =~ @i_face.getsets
			    @getsets << $2.to_s
			elsif line =~ @i_face.methods
				if $5 != nil and $2 != nil
					@methods << "#{$1.to_s}(#{$2.to_s}):#{$5.to_s}"
				else
					method_scans << $1
				end		
			end
			
		end
		
		store_multiline_interface_methods(doc,method_scans)
		
		@depth += 1

	end
	
	def store_static_members(doc)

		return if doc.nil?

		doc.each do |line|

			if line =~ @pub_stat.vars
				@static_properties << $4.to_s
			elsif line =~ @pub_stat.getsets
				@static_properties << $4.to_s
			elsif line =~ @pub_stat.methods
				@static_methods << "#{$3.to_s}()"
			elsif line =~ @private_class_regexp
				break
			end

		end

	end

	# ====================
	# = Document Loaders =
	# ====================

	# Loads and returns the superclass of the supplied doc.
	def load_parent(doc)

		# Scan evidence of a superclass.
		doc.scan(@extends_regexp)
		
		# If we match then convert the import to a file reference.
		if $9 != nil
			possible_parent_paths = imported_class_to_file_path(doc,$9)
			log_append("Loading super class '#{$9}' '#{possible_parent_paths[0]}'.")
			return load_class( possible_parent_paths )
		end

		# ActionScript 3 makes extending object's optional when writing code. 
		# However all classes are decendants of Object, so add it here.
		doc.scan(/^\s*(public dynamic class Object)/)
		
		unless $1
			log_append("Loading super class 'Object' 'Object.as'.")
			return load_class(["Object.as"]) 
		end
		
		return nil

	end
		
	# Adds all class members to our lists.
	def add_doc(doc)

		return if doc.nil?

		store_all_class_members(doc)

		next_doc = load_parent(doc)

		# Start recursing superclasses.
		add_public_and_protected(next_doc)

 	end

	# Adds all public and protected methods and properties to our lists.
	def add_public_and_protected(doc)

		return if doc.nil?

		store_public_and_protected_class_members(doc)

		next_doc = load_parent(doc)
		add_public_and_protected(next_doc)

	end

	# Adds all public instance methods and properties to our lists.
	def add_public(doc)

		return if doc.nil?

		store_public_class_members(doc)

		next_doc = load_parent(doc)
		add_public(next_doc)

	end
	
	# Adds all interface methods and properties to our lists.
	def add_interface(doc)

		return if doc.nil?
		
		store_interface_members(doc)

		next_docs = load_interface_parents(doc)
		
		unless next_docs.nil? or next_docs.empty?
			next_docs.each { |d| add_interface(d) }
		end

	end

	# When processing interfaces we may need to load multiple parents.
	def load_interface_parents(doc)
		
		doc.scan(@interface_extends_regexp)
		
		if $7
			
			extending = $7.gsub(/\n|\s/,'').split(",")
			ex_str = extending.join("\n")
			
			#log_append("WARNING: Interfaces with more than one ancestor are not supported.")
			#log_append("These interfaces could be missing from the output\n #{ex_str} \n\n" )
			
			unless extending.empty?

				#TODO: Load all the references found in extending.
				exteding_interfaces = []
				
				extending.each do |ext|
					p = imported_class_to_file_path(doc,ext)
					c = load_class(p)
					exteding_interfaces << c if c != nil
				end
				 
				return exteding_interfaces unless exteding_interfaces.empty?
				
			end
		end
		
		return nil;
		
	end

	# ================
	# = Path Finding =
	# ================
	
	# Collects all of the src directories into a list.
	# The resulting list of dirs is then used when locating source files.
	def create_src_list

		if ENV['TM_PROJECT_DIRECTORY']

			src_list = '"src"'
			
			# This isn't working properly yet as it only matches the top level lib
			# within the Proj.
			#if ENV['TM_AS3_USUAL_SRC_DIRS'] != nil
			#	src_a = ENV['TM_AS3_USUAL_SRC_DIRS'].split(":")
			#	src_list = '"' + src_a.pop() + '"'
			#	src_a.each do |d|
			#		src_list += ' -or -name "'+d+'"'
			#	end
			#end
			
			# Note Errors are redirected and suppressed (ie Permissions Errors)
			@src_dirs = `find -d "$TM_PROJECT_DIRECTORY" -maxdepth 5 -name #{src_list} -print 2>/dev/null`
			
		end

		cs = "#{@completion_src}/data/completions"
		
		# Check once for existence here as we will save repeated
		# checks later (whilst walking up the heirarchy).
		add_src_dir("#{cs}/intrinsic")
		add_src_dir("#{cs}/frameworks/air")
		add_src_dir("#{cs}/frameworks/flash_ide")
		add_src_dir("#{cs}/frameworks/flash_cs3")

		# Where we have access to the compressed flex 3 files use them,
		# otherwise go looking for the sdk.
		unless add_src_dir("#{cs}/frameworks/flex_3")
			fx = FlexMate.find_sdk_src
			add_src_dir(fx)
		end

		#log_append( "src_dirs " + @src_dirs )

 	end

	# Helper for create_src_list
	def add_src_dir(path)
		if File.directory?(path)
			@src_dirs += "#{path}\n"
			return true
		end
		return false
	end

	# Finds the class in the file system.
	# If successful the class is loaded and returned.
	# paths is an array of relative class paths.
	def load_class(paths)

		urls= []

		@src_dirs.each do |d|

			paths.each do |path|

				uri = d.chomp + "/" + path.chomp

				if @loaded_documents.include?(uri)
					log_append("Already added #{uri}")
					return nil 
				end
				
				#FIX: The assumption that we'll only find one match.
				if File.exists?(uri)
					@loaded_documents << uri
					f = File.open(uri,"r" ).read.strip
					f = load_includes(f,uri)
					return strip_comments(f)
				end

			end

		end

		as_file = File.basename(paths[0])

		@exit_message = "Completions incomplete.\nThe class #{as_file.sub!(/\.as$/,'')} was not found."

		log_append("Unable to load '#{as_file}'")

		nil
	end

	# Searches the given document for the import statement of the specified class,
	# if located it returns it as a file path reference. Where no explicit import 
	# is delared wildcarded imports are accumulated, alongside the classes package 
	# path and returned.
	#
	# Returns an array of possible file paths, ie ["org/helvector/Foo.as"]
	def imported_class_to_file_path(doc,class_name)

		possible_paths = []

		# Check for explicit import statement.
		doc.scan( /^\s*import\s+(([\w+\.]+)(\b#{class_name}\b))/)

		unless $1.nil?
			p = $1.gsub(".","/")+".as"
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

		# Even though we are very likely to have a package path by this point
		# add in a top level match for safetys sake.
		return possible_paths << "#{class_name}.as"

	end

	# ========================
	# = Utitlity / Stripping =
	# ========================
	
	# Strips comments from the document. This is designed to leave whitespace in
	# their place so the caret position remains correct.
	def strip_comments(doc)

		multiline_comments = /\/\*(?:.|([\r\n]))*?\*\//
		doc.gsub!(multiline_comments) do |s|
			if $1
				r = ""
				a = s.split("\n")
				r += "\n" * (a.length-1) if a.length > 1
				r
			end
		end

		single_line_comments = /\/\/.*$/
		return doc.gsub(single_line_comments,'')

	end
	
	# Determines whether or not the supplied document is an interface.
	def is_interface(doc)
		doc.scan(@interface_regexp)
		if $1 == "interface"
			return true
		end
		return false
	end
	
	# Load inlcudes references
	def load_includes(doc,uri)
		
		# TODO: We need to load included files but retain our caret position within
		# the file (for local type detection). May be possilbe to append to the end of
		# a file IF there's no private classes. Otherwise we could increment the caret
		# position by the number of lines added?
		
		doc.each do |line|
			if line =~ /^\s*include\s+"([\w.\/]+)";$/
				include_path = File.dirname(uri)+"/#{$1}"
				log_append("WARNING Not Loaded Include " + include_path)
			end
		end
		
		doc
	end
	
	# ==========================
	# = Type Locating Commands =
	# ==========================

	# Searches a document for the type of the specified property.
	#
	# Returns an array.
	# First element being the document that contains the ref.
	# Second element being the type of the reference.
	def determine_type_globally(doc,reference)

		return if doc.nil?
		
		# TODO: Consider the logic of what we are doing here, specifically do we
		# 	    need to introduce a 'public' only match as we are only interested
		#       in public variables once @type_depth > 0 IF we are inspecting a
		# 		a chain of property references. So in: thing.foo.bar thing is
		#       local to the class and could be ppp (pp in the supers), but foo
		#       can only be a public property.

		namespace = "protected|public"
		namespace = "private|protected|public" if @type_depth == 0		
		namespace = "" if is_interface(doc)

		# Variables and Constants
		var_regexp = /^\s*(#{namespace})\s+(var|const)\s+\b(#{reference})\b\s*:\s*((\w+)|\*)/
		
		doc.scan(var_regexp)
		if $4 != nil
		    log_append("Type determined as '#{$4}' in global scope.")
		    return [doc,$4]
		end
		
		# Statics.
		var_regexp = /^\s*(#{namespace}|static)\s+(#{namespace}|static)\s+\bvar\s+\b(#{reference})\b\s*:\s*((\w+)|\*)/
		
		doc.scan(var_regexp)
		if $4 != nil
		    log_append("Type determined as '#{$4}' in global scope.")
		    return [doc,$4]
		end


		# Also picks up single line methods.
		# TODO: public static function getInstance():IFacade {
		get_regexp = /^\s*(#{namespace}|static)\s+(#{namespace}|static)?\s*\bfunction\s+(get\s+)?\b(#{reference})\b\s*\(.*\)\s*:\s*((\w+)|\*)/

		doc.scan(get_regexp)
		if $6 != nil
			if $6 == "void"
				@return_type_void = true
				log_append("Return Type determined as '#{$6}' (void) in global scope.")
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
	#
	# Returns an array.
	# First element being the document that contains the ref.
	# Second element being the type of the reference.
	#
	# TODO: This makes the assumption that we're  within a method, which is in
	#       no way guaranteed.
	def determine_type_locally(doc,reference)

		# Conditionals may cause problems...
		type_regexp = /\s*(\b#{reference}\b)\s*:\s*(\w+)/

		if doc.nil?
			log_append( "No doc for #{reference} !" )
			return
		end

		d = doc.split("\n")
		ln = ENV['TM_LINE_NUMBER'].to_i-1

		while ln > 0

			txt = d[ln].to_s

			if txt =~ type_regexp

				#log_append( "Type locally matched as \n\t#{txt}." )
				log_append( "Type locally matched as #{$2}." )

				return [doc,$2]

			elsif txt =~ @pri.methods

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
		type = determine_type_globally(doc,reference) if type.nil?

		return type

	end

	# Utility method for search_ancestor which uses the level to
	# track the depth of recursion, if it's 0 then we are operating
	# at a local level.
	def determine_type_at_level(doc,reference,depth)
		if reference =~ @static_member_regexp
			return [doc,reference]
		end
		return determine_type_all(doc,reference) if depth == 0
		return determine_type_globally(doc,reference)
	end

	# Searches a property chain for the type of its last item.
	#
	# So, with 'thing.foo.bar' we start searching for 'thing' in the local
	# document, then it's super classes, when it's type is located that
	# class is opened and we start searching for foo, etc, etc,
	#
	# Important to remember that we are searching in two directions
	#
	# 	* Horizontally along the property chain.
	#   * Vertically through the class the ancestry.
	#
	# doc is the current class document.
	# property_chain is an array of properties to check - ie, propA.propB.propC
	def search_ancestor(doc,property_chain,depth=0)

		find_type = property_chain.shift
		find_type = property_chain.shift if find_type =~ /this/

		if find_type =~ /(\s*(\w+\s*)?)\(.*\)/
			#log_append("Stripped method call #{$1} #{find_type}")
			find_type = $1
		end

		if property_chain.size == 0

			# Reached the last item in the list.
			type = determine_type_at_level(doc,find_type,depth)

			return nil if type.nil?
			
			log_append("Located "+ find_type + " as #{type[1]} ")
			
			return type

		else

			log_append("Finding "+ find_type)

			# Recurse down.
			type = determine_type_at_level(doc,find_type,depth)

			return nil if type.nil?

			path = imported_class_to_file_path(type[0],type[1])

			log_append("Found '#{find_type}' here '#{path.join(", ")}'")
			
			#Reset loaded docs as we are running again.
			@loaded_documents = []
			
			child_doc = load_class(path)

			return search_ancestor(child_doc,property_chain, depth+=1)

		end

	end
	
	# Attempts to find the type of the reference within the doc.
	def determine_type(doc,reference)

		# Class Members.
		if reference =~ @static_member_regexp
			
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

		property_chain = [reference]
		
		if reference.match( /\./)
			property_chain = reference.split(".")
		end
    
		# Where casting has occoured we may have a short cut to exploit as the type
		# we are searching for at that point in the chain will be referenced in the 
		# local document.
		shortcut = nil
		property_chain.reverse.each do |p|
			if p =~ @static_member_regexp
				shortcut = p
				break
			end
		end
		
		property_chain.slice!(0,property_chain.rindex(shortcut)) if shortcut
    
		log_append("Ancestor list: "+property_chain.join(", "))
		return search_ancestor(doc,property_chain)
    
		end

	end
	
	public
	
	# ==================
	# = Input Commands =
	# ==================

	# Loads a full instance or class level member list for the class
	# document using the reference to determine the type of the class.
	def load(doc,reference)

		# Set our depth counters to defaults.
		@depth = 0
		@type_depth = 0

		#doc = load_includes(doc,"#{ENV['TM_FILEPATH']}")
		doc = strip_comments(doc)
		
		# Super Instance Members.
		if reference =~ /^super$/

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
				
				#Reset our loaded documents list.
				@loaded_documents = []

				path = imported_class_to_file_path(type[0],type[1])
				cdoc = load_class(path)
				if cdoc != nil					
					if is_interface(cdoc)
						add_interface(cdoc)
					else
						add_public(cdoc)
					end					
				end

			else

				@exit_message = "Failed to locate type of '#{reference}'."
				log_append(@exit_message)

			end

		end

		# TODO: Check type of method return statements.

	end

	# Returns the type of the reference within the doc.
	def find_type(doc,reference)
		type = determine_type(doc,reference)
		return type[1].to_s if type != nil
		return nil
	end
	
	# Sets the location of the completions src directory.
	def completion_src=(dir)
		if File.directory?(dir)
			@completion_src = dir
			@src_dirs = ""
			create_src_list()			
		end
	end
	
	# Loads all the public methods, accessors and properties of the specified Class.
	# Expects class ref to be in the format org.foo.BarClass
	def load_reference(class_ref,include_meta=false)
		@include_metadata = include_meta
		path = [class_ref.gsub(".","/") + ".as"]
		cdoc = load_class(path)
		add_public(cdoc)
	end
	
	# Loads all the static members of the requested class.
	def load_statics(doc,reference)
		
		path = imported_class_to_file_path(doc,reference)
		log_append( "Processing #{reference} as static. #{path}" )
		store_static_members( load_class(path) )
		
	end
	
	# ==================
	# = Ouput Commands =
	# ==================

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

	# List of getter setter names.
	def gettersetters
		return if @getsets.empty?
		@getsets.uniq.sort
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
	
	# List of effects described in the class meta-data.
	def effects
		return if @effects.empty?
		@effects.uniq.sort
	end

	# List of events described in the class meta-data.	
	def events
		return if @events.empty?
		@events.uniq.sort		
	end
	
	# List of effects described in the class meta-data.
	def styles
		return if @styles.empty?
		@styles.uniq.sort		
	end
	
	# ===========
	# = Logging =
	# ===========

	private
	
	def log_append(message)
		@log += "#{message}\n"
	end
	
	public
	
	# Log messages.
	def log
		@log
	end
	
	# String to show in tooltip when the parsing has failed.
	def exit_message
		@exit_message
	end

	# Boolean set to true when a memeber is discovered as having a void return
	# type.
	def return_type_void
		@return_type_void
	end

end

class AsClassRegex

	attr_reader :vars
	attr_reader :methods
	attr_reader :getsets
	attr_reader :events
	attr_reader :effects
	attr_reader :styles

	def initialize(ns)

		# TODO, Check that static regexp need to be different.
		if ns =~ /static/

			@vars = /^\s*\b(#{ns})\b\s+\b(#{ns})\b\s+\b(var|const)\b\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
			@methods = /^\s*\b(#{ns})\b\s+\b(#{ns})\b\s+function\s+\b([a-z]\w+)\b\s*\(/
			@getsets = /^\s*\b(#{ns})\b\s+\b(#{ns})\b\s+function\s+\b(get|set)\b\s+\b([a-z]\w+)\b\s*\(/

		else

			@vars 	 = /^\s*(#{ns})\s+var\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
			@methods = /^\s*(override\s+)?(#{ns})\s+function\s+\b([a-z]\w+)\b\s*\(([^)\n]*)(\)(\s*:\s*(\w+|\*))?)?/			
			@getsets = /^\s*(override\s+)?(#{ns}\s+)?function\s+\b(get|set)\b\s+\b(\w+)\b\s*\(/
			
			# Class Meta-data.
			@events = /\[\s*Event\s*\(\s*name\s*="(\w+)"\s*,\s*type\s*=\s*"([\w.]+)"\s*\)\s*\]/
			@effects = /\[\s*Effect\s*\(\s*name\s*="(\w+)"\s*,\s*event\s*=\s*"([\w.]+)"\s*\)\s*\]/
			@styles = /\[\s*Style\s*\(\s*name="(\w+)".*\s*\)\s*\]/

		end

	end

end

class AsInterfaceRegex
	
	attr_reader :methods
	attr_reader :getsets	
	
	def initialize()

			#@methods = /^\s*function\s+\b([a-z]\w+)\b\s*\((.*)(\)(\s*:\s*(\w+|\*))?)?/
			@methods = /^\s*function\s+\b([a-z]\w+)\b\s*\(([^)\n]*)(\)(\s*:\s*(\w+|\*))?)?/
			@getsets = /^\s*function\s+\b(get|set)\b\s+\b(\w+)\b\s*\(/

	end
		
end

class AsMember
	attr_accessor :namespace
	attr_accessor :name
	attr_accessor :type
	attr_accessor :parameters
	attr_accessor :storage_type
end
