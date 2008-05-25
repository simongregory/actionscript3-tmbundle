#!/usr/bin/env ruby -wKU

# Collection of declaration snippets for use
# within public, protected or private namespaces.

as3_doc = ENV['TM_ASDOC_GENERATION']
@include_docs = as3_doc ? true : false

@private_doc = "/**\n *	@private\n */"
@constructor_doc = "/**\n *	@constructor\n */"
@method    = " function ${1:name}($2):${3:void}\n{\n\t$0${3/void$|(.+)/(?1:return null;)/}\n}"
@getter    = " function get ${1:name}():${2:Object}{\n\treturn ${3:_$1};\n}$0"
@setter    = " function set ${1:name}(value:${2:Object}):void {\n\t${3:_$1} = value;\n}$0"
@variable  = " var _${1:variableName}:${2:Object};"
@property  = " var ${1:propertyName}:${2:Object};"
@namespace = " namespace ${1:nameSpaceName};"
@constant  = " const ${1:CONSTANT_NAME}:${2:Object};"

@static_variable = "static" + @property
@static_method = "static" + @method
@static_constant = "static" + @constant

@class_doc = "/**
 *  ${1:Description}
 *    
 *  @langversion ActionScript ${2:3}
 *  @playerversion Flash ${3:9.0.0}
 *
 *  @author ${4:"+ENV['TM_FULLNAME']+"}
 *  @since  ${5:"+`date +%d.%m.%Y`.chop+"}
 */"

# Public Methods

def get_statics()
    r = [ 
        list_object('static const', @static_constant),
        list_object('static function', @static_method),
        list_object('static var', @static_variable)
    ]
end

def get_snippets(ns)
    
    v = ns == "public" ? @property : @variable
    
    r = [
          list_object( 'function',  ns + @method ), 
          list_object( 'get',       ns + @getter ),      
          list_object( 'set',       ns + @setter ), 
          list_object( 'var',       ns + v ),
          list_object( 'namespace', ns + @namespace )          
    ]

    if ns != "protected" 
        r += [
            { 'title' => '----'},
            list_object( 'static const',    ns + " static" + @constant ),
            list_object( 'static function', ns + " static" + @method   ), 
            list_object( 'static get',      ns + " static" + @getter   ), 
            list_object( 'static set',      ns + " static" + @setter   ), 
            list_object( 'static var',      ns + " static" + v         )
        ]
    end
    
    return r
end

def class_snip(ns)

    fn = ENV['TM_FILENAME']
    cn = "NewClass"    
    cn = File.basename(fn,".as") if fn != nil
	
	if @include_docs
		
	return "/**
 *  Description
 *    
 *  @langversion ActionScript 3
 *  @playerversion Flash 9.0.0
 *
 *  @author "+ENV['TM_FULLNAME']+"
 *  @since  "+`date +%d.%m.%Y`.chop+"
 */
#{ns} class ${1:#{cn}} extends ${2:Object} {
	
	/**
	 *   @constructor
	 */
	public function $1($3){
		super();$4
	}$0
}"
		
	else

		return "#{ns} class ${1:#{cn}} extends ${2:Object} {
	
	public function $1($3){
		super();$4
	}$0
}"
		
	end

end

def method(name)
    
    if name != ""
        m = "public" + @method.sub("${1:name}","${1:"+name+"}")
    else
        m = "public" + @method
    end
    
    if @include_docs
        m = @private_doc + "\n" + m
    end
        
    return m    
end

def final_method
	
    m = "final" + @method
    
    if @include_docs
        m = @private_doc + "\n" + m
    end
        
    return m
end

# Getter/Setters

def getter
    @getter
end

def setter
    @setter
end

def class_doc
	@class_doc
end

def private_doc
	@private_doc
end

def constructor_doc
	@constructor_doc
end

# Private methods

def list_object(title,data)
    if @include_docs 
        return { 'title' => title, 'data' => @private_doc + "\n" + data}
    end
    return { 'title' => title, 'data' => data}
end
