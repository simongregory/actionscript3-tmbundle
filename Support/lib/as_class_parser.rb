# A Utilty class to convert an ActionScript class into
# list of it's constituent methods and properties.
#
# As long as the src is available, this will
# traverse the ancestry of the class adding all
# public and protected methods and properties.
class AsClassParser
    
    private
    
	def initialize
		
		@log = ""
        
        #Used to track how far up the class ancestory we are.
		@depth = 0
		@type_depth = 0
		
		@src_dirs    = []		
		@methods     = []	
		@properties  = []
		@privates    = []		
		@all_members = []

		# Captures public namespaces.
		@pub_var_regexp    = /^\s*(public)\s+var\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		@pub_getset_regexp = /^\s*(override\s+)?(public)\s+function\s+\b(get|set)\b\s+\b(\w+)\b\s*\(/		
		@pub_method_regexp = /^\s*(override\s+)?(public)\s+function\s+\b([a-z]\w+)\b\s*\(/		
		
		# Captures public and protected namespaces.
		# TODO: Add public|protected-static-method|var|const
		@var_regexp    = /^\s*(protected|public)\s+var\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		@getset_regexp = /^\s*(override\s+)?(protected|public)\s+function\s+\b(get|set)\b\s+\b(\w+)\b\s*\(/		
		@method_regexp = /^\s*(override\s+)?(protected|public)\s+function\s+\b([a-z]\w+)\b\s*\(/

		# Captures all namespaces.
		# TODO: Add public|protected|private-static-method|var|const		
		@all_var_regexp    = /^\s*(private|protected|public)\s+var\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		@all_getset_regexp = /^\s*(override\s+)?(private|protected|public)\s+function\s+\b(get|set)\b\s+\b(\w+)\b\s*\(/		
		@all_method_regexp = /^\s*(override\s+)?(private|protected|public)\s+function\s+\b([a-z]\w+)\b\s*\(/
		
		# Captures public class level members
        # TODO: Add Accessors.
		@static_method = /^\s*(public)\s+(static\s+)function\s+\b([a-z]\w+)\b\s*\(/
		@const_regexp = /^\s*\b(public|static)\b\s+\b(static|public)\b\s+\b(var|const)\b\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		
		#Type detection captures.
		@extends_regexp = /^\s*(public)\s+(dynamic\s+)?(final\s+)?(class|interface)\s+(\w+)\s+(extends)\s+(\w+)/		
		@private_class_regexp = /^class\b/
		
		create_src_list()
		
    end
    
    # Collects all of the src directories into a list.
    # The resulting list of dirs is then used when 
	# locating source files.
	def create_src_list
		@src_dirs = `find "$TM_PROJECT_DIRECTORY" -maxdepth 5 -name "src" -print`
		@src_dirs += "#{ENV['TM_BUNDLE_SUPPORT']}/data/src"
 	end
			
	# Finds the class in the filesystem.
	# If successful the class is loaded and returned.
	def load_class(path)
		@src_dirs.each { |d|
			uri = d.chomp + "/" + path
			#FIX: The assumption that we'll only find one match.
			if File.exists?(uri)
				return File.open(uri,"r" ).read.strip
			end
		}	
		nil
	end

	# Store instance members for the class doc.
	def add_class_members(doc)

		return if doc == nil

		@log += "Adding completions at level " + @depth.to_s + "\n"

        meth = @method_regexp
		vars = @var_regexp
		gs   = @getset_regexp

		if @depth < 1
			meth = @all_method_regexp
		    vars = @all_var_regexp
			gs   = @all_getset_regexp
		end
		
		doc.each do |line|
			
			if line =~ vars
		  		@properties << $2.to_s  
			elsif line =~ meth
			    @methods << $3.to_s + "()"
			elsif line =~ gs
			    @properties << $4.to_s
		    elsif line =~ @private_class_regexp
		        break
			end
			
		end
		
		@depth += 1
		
	end
	
	# Store instance members for the class doc.
	def add_public_class_members(doc)

		return if doc == nil

		@log += "Adding completions at level " + @depth.to_s + "\n"
		
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
	
	# Search and store the static completions for doc.
	def parse_statics(doc)
		
		return if doc == nil
		
		doc.each do |line|
			
			if line =~ @const_regexp
		  		@properties << $4.to_s  
			elsif line =~ @static_method
			    @methods << $3.to_s + "()"
            elsif line =~ @private_class_regexp
                break    		    
			end
			
		end
		
	end
	
	# Add items to full list of properties.
	def add_to_all_members(items_to_add)
	    return if items_to_add == nil
	    if items_to_add.size > 0
	        @all_members.push('-') if @all_members.size > 0
	        @all_members = @all_members + items_to_add
	    end
	end
	
	# Loads and returns the superclass of the supplied doc.	
	def load_parent_doc(doc)

		# Scan evidence of a superclass.
		doc.scan(@extends_regexp)
		
		# If we match then convert the import to a file reference.
		if $7 != nil
			parent_path = doc_path_from_class_reference(doc,$7)
			@log += "Loading super class #{$7}.\n"
			return load_class( parent_path )			
		end
		
		return nil
	end
	
	# Pass a class to start the ball rolling.
 	def add_doc(doc)
		
		return if doc == nil
		
		add_class_members(doc)

		next_doc = load_parent_doc(doc);
		add_doc(next_doc)
		
 	end
	
	# Pass a class to start the ball rolling.
 	def add_public(doc)
		
		return if doc == nil
		
		add_public_class_members(doc)

		next_doc = load_parent_doc(doc);
		add_public(next_doc)
		
 	end
	    
	# Searches the given document and determines the
	# document path using the class_name reference.
	# NOTE: This relies on the reference being imported.
	# TODO: Add support for wildcarded imports.	
	# 		Do this by expanding/loading all the classes in package?
    # 		ie import flash.net.*;    
	def doc_path_from_class_reference(doc,class_name)

		# Use import statment to find our doc.
        doc.scan( /^\s*import\s+(([\w+\.]+)(\b#{class_name}\b))/)
        
        return $1.gsub(".","/")+".as" if $1 != nil

		# Assume it's top level.
		return class_name + ".as"
		
	end
	
	# Searches a document for the type of the specified property.
	def determine_type_globally(doc,reference)
		
		return if doc == nil

		scope = "protected|public"
		scope = "private|protected|public" if @type_depth == 0

		# TODO: Should this be global? So it's not created on each recursion.
		# 		Method paramaeters are likely to need work for the accessor.
		var_regexp = /^\s*(#{namespace})\s+var\s+\b(#{reference})\b\s*:\s*((\w+)|\*);/
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
		next_doc = load_parent_doc(doc);
		determine_type_globally(next_doc,reference);
		
	end

	# Searches the local scope for a var declaration
	# and returns it's type if found.
	# TODO: As this makes the assumption that we're 
	# 		within a method. Which is in no way guaranteed.
	def determine_type_locally(doc,reference)
		
		# Conditionals may cause problems...
		type_regex = /\s*(\b#{reference}\b)\s*:\s*(\w+)/		
		
		d = doc.split("\n")
		ln = ENV['TM_LINE_NUMBER'].to_i-1

		while ln > 0

		    txt = d[ln].to_s
			
			if txt =~ type_regexp

				@log += "Type locally matched as #{txt}.\n"
				
				return $2
				
			elsif txt =~ @all_method_regexp
				
				#When we hit a method statement exit.
				@log += "Type not located locally.\n"
				return nil
				
			end
			
		    ln -= 1

		end
		
		@log += "Type locally failed!?\n"
		return nil
	end
	
    public
    
	# Input Commands
	
    # Loads a full instance or class level member list for the class
	# document using the reference to determine the type of the class.
    def load(doc,reference)
		
		# Set our depth counters to defaults.
        @depth = 0
		@type_depth = 0        
	
		# Class Members.
		if reference =~ /^([A-Z]|\b(uint|int)\b)/
						
			path = doc_path_from_class_reference(doc,reference)
			@log += "Processing #{reference} as static. #{path}\n"
	        cdoc = load_class(path)
			parse_statics(cdoc) if cdoc != nil

		# Super Instance Members.
		elsif reference =~ /^super$/
			
			super_class = load_parent_doc(doc)
			@log += "Processing #{reference} as super class.\n"
			@depth = 1
			add_doc(super_class)

		# This Instance Members.
		elsif reference =~ /^(this)?$/
            
			add_doc(doc)
            @log += "Processing #{reference} as this.\n"
            
		# Instance Members.
		else
			
            @log += "Processing #{reference} as an instance.\n"
            
			type = determine_type(doc,reference)
			
			if type != nil
				
			    @log += "#{type} located.\n"
				path = doc_path_from_class_reference(doc,type)
				cdoc = load_class(path)
				add_public(cdoc,false) if cdoc != nil
				
			else
				
			    @log += "Failed to locate type of #{reference}.\n"
			
			end
			
		end
		
		# TODO: Check type of method return statements.
		
    end
	
	# Attempts to fin the type of the reference within the doc.
	def determine_type(doc,reference)
		
		# Class Members.
		if reference =~ /^([A-Z]|\b(uint|int)\b)/

			return reference
			
		# Super Instance Members.
		elsif reference =~ /^super$/
			
			# Scan evidence of a superclass.
			doc.scan(@extends_regexp)
			return "" if $7 == nil
			return $7			

		# This Instance Members.
		elsif reference =~ /^(this)?$/
            
			# Locate class name.			
			doc.scan(/^\s*(\b(public|dynamic|final)+)\s+(class|interface)\s+(\w+)\s+/)
			return "" if $4 == nil
			return $4			
            
		# Instance Members.
		else
			            
            @log += "Processing #{reference} as an instance.\n"
                        
			type = determine_type_locally(doc,reference)
			type = determine_type_globally(doc,reference) if type == nil
			
			#return "" if type == nil
			return type
			
		end
		
	end
	
    # Ouput Commands
    
    # Returns accumulated method completions.
    def methods
        
        return if @methods.empty?        
        @methods.uniq.sort
        
    end
	
	# Returns accumulated property completions.
	def properties
				
		return if @properties.empty?
		@properties.uniq.sort
		
	end
	
	# Returns accumulated private completions.
	# Only when working in a local scope.
	def privates
	   @privates.uniq.sort
	end
	
	# Returns any debug log data accumulated during parsing.
	def log
		@log
	end
	
	# Return a list of all members currently held.
	def all_members
		@all_members = []
		add_to_all_members(properties)
		add_to_all_members(methods)
		add_to_all_members(privates)
		return @all_members
	end
	
end
