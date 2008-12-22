#!/usr/bin/env ruby -wKU

# UI for public, protected, private and static snippets. 
#
module SnippetController
	
	class << self

		# Collects and returns all snippets that belong to public, protected 
		# and private triggers.
		#
		def namespace(ns='public')
    
				t = SnippetBuilder.new

		    snips = [ { 'title' => 'function',  'data' => t.method("name",ns)   },
								  { 'title' => 'get',       'data' => t.getter("name",ns)   },
								  { 'title' => 'set',       'data' => t.setter("name",ns)   },
								  { 'title' => 'var',       'data' => t.var("name",ns) 		  } 
				]

		    if ns != "protected" 
						sns = "#{ns} static"
		        snips += [
		            { 'title' => '----'},
								{ 'title' => 'static const',  	'data' => t.const("name", sns)    },
								{ 'title' => 'static function', 'data' => t.method("name", sns)    },
								{ 'title' => 'static get',  		'data' => t.getter("name", sns)    },
								{ 'title' => 'static set',  		'data' => t.setter("name", sns)    },
								{ 'title' => 'static var',  		'data' => t.var("name", sns)    },
		        ]
		    end
    
		    snip = TextMate::UI.menu(snips)

				TextMate.exit_insert_text(ns) if snip == nil
				TextMate.exit_insert_snippet( snip['data'] )
				
		end
		
		# Collects and returns all snippets that belong to static triggers.
    #
		def statics(ns="public")
			
			t = SnippetBuilder.new
			ns += " static"
			
	    snips = [ { 'title' => 'const',  		'data' => t.const("name",ns)   },
							  { 'title' => 'function',  'data' => t.method("name",ns)   },
							  { 'title' => 'get',       'data' => t.getter("name",ns)   },
							  { 'title' => 'set',       'data' => t.setter("name",ns)   },
							  { 'title' => 'var',       'data' => t.var("name",ns) 		  } 
			]
			
			snip = TextMate::UI.menu(snips)

			TextMate.exit_insert_text('static') if snip == nil
			TextMate.exit_insert_snippet( snip['data'] )
			
		end
		
	end
	
end