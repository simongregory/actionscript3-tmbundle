#!/usr/bin/env ruby -wKU

# Collection of declaration snippets for use
# within public, protected or private namespaces.

@method    = " function ${1:name}($2):${3:void}{\n\t$0${3/void$|(.+)/(?1:return null;)/}\n}"
@getter    = " function get ${1:name}():${2:Object}{\n\treturn ${3:_$1};\n}$0"
@setter    = " function set ${1:name}(value:${2:Object}):void {\n\t${3:_$1} = value;\n}$0"
@variable  = " var _${1:variableName}:${2:Object};"
@property  = " var ${1:propertyName}:${2:Object};"
@namespace = " namespace ${1:nameSpaceName};"
@constant  = " const ${1:CONSTANT_NAME}:${2:Object};"

@static_variable = "static" + @property
@static_function = "static" + @method
@static_constant = "static" + @constant

def get_statics()
    r = [ 
        list_object('static const', @static_constant),
        list_object('static function', @static_function),
        list_object('static var', @static_variable)
    ]
end

def get_snippets(ns)
    
    v = ns == "public" ? @property : @variable
    
    r = [
          list_object( 'function',  ns + @method), 
          list_object( 'get',       ns + @getter),      
          list_object( 'set',       ns + @setter), 
          list_object( 'var',       ns + v),
          list_object( 'namespace', ns + @namespace)          
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

# Getter/Setters

def getter
    @getter
end

def setter
    @setter
end

def method(name)
    if name != ""
        m = @method.sub( "${1:name}", "${1:"+name+"}")
        return m
    end
    return @method    
end

def list_object(title,data)
    return { 'title' => title, 'data' => data}
end