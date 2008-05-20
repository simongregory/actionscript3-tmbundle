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
		@depth = 0
		
		@src_dirs = []		
		@methods = []	
		@properties = []
		
		@var_regexp = /^\s*(protected|public)\s+var\s+\b(\w+)\b\s*:\s*((\w+)|\*);/
		@method_regexp = /^\s*(override\s+)?(private|protected|public)\s+function\s+\b([a-z]\w+)\b\s*\(/
		@getset_regexp = /^\s*(private|protected|public)\s+function\s+\b(get|set)\b\s+\b(\w+)\b\s*\(/		

		#@static_method = /^\s*(private|public)\s+(static\s+)function\s+\b([a-z]\w+)\b\s*\(/
		#@const_regexp = /^\s*\b(private|public|static)\b\s+\b(static|public|private)\b\s+\b(var|const)\b\s+\b(\w+)\b\s*:\s*((\w+)|\*)/
		
		@extends_regexp = /^\s*(public)\s+(dynamic\s+)?(class|interface)\s+(\w+)\s+(extends)\s+(\w+)/
		
		create_src_list
		
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
	def load_parent(path)
		@src_dirs.each { |d|
			uri = d.chomp + "/" + path
			#FIX: The assumption that we'll only find one match.
			if File.exists?(uri)
				return File.open(uri,"r" ).read.strip
			end
		}	
		nil
	end
	
	# Search and store the completions for doc.
	def parse_completions(doc)
		
		@log += "Adding completions at level " + @depth.to_s + "\n"
		
		doc.each do |line|
			
			if line =~ @var_regexp
		  		@properties << $2.to_s  
			elsif line =~ @method_regexp
			    @methods << $3.to_s + "()"
			elsif line =~ @getset_regexp
			    @properties << $3.to_s
			end
		end
		
		@depth += 1
		
	end

    public
    
	# Input Commands
	
	# Pass a class to start the ball rolling.
 	def add_doc(doc)
		
		# Add the methods and properties contained within the doc.
		parse_completions(doc)

		# Scan the doc for extends.
		doc.scan(@extends_regexp)
		
		# If we match then convert the import to a file reference.
		if $6 != nil
			
			# Lets try assuming the class is top level
			parent_class_path = $6
			
		    doc.scan( /^\s*import\s+([\w+\.]+)(#{parent_class_path})/)
			
			# When we get an import use it to find our doc.
			if $1 != nil
				parent_class_path = $1+parent_class_path
			end
		    
		    parent_path = parent_class_path.gsub(".","/")+".as"

			@log += "Loading file " + parent_path + "\n"
			
			next_doc = load_parent( parent_path )
			
			#Recurse up to the parent.
			add_doc next_doc if next_doc != nil
			
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
	
	# Returns any debug log data accumulated during parsing.
	def log
		@log
	end

end
