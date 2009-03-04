#!/usr/bin/env ruby -wKU

################################################################################
#
# TextMate Flex Compiler Config Language and AutoCompletion Generator.
#
################################################################################

require "rexml/document"
require '/Applications/TextMate.app/Contents/SharedSupport/Support/lib/osx/plist'

base_path = File.dirname(__FILE__)

# To generate the config file try `mxmlc -dump-config file-name-config.xml`
conf = "#{base_path}/../data/flex-config.xml"

doc = ""

# Loads the config file. Additionally uncomments any tags that are left
# commented by -dump-config
IO.foreach(conf) { |line|
	line.sub!(/usage:\n/, 'usage: -->')
	doc << line.sub(/^\s+-->$/, '')
}

$repository = []

def create_repository_groups(node,scope='')

	name = node.name()

	attrib = ''
	attrib = '( append="true")?' if node.attributes['append']

	scope = "#{scope}.#{name}"
	repository_element = "\t\t#{name.sub('3','-three')} = {
			contentName = 'meta.scope#{scope}';
			begin = '<#{name}#{attrib}>';
			end = '</#{name}>';
			captures = { 0 = { name = 'meta.tag.xml#{scope}'; }; };\n"

	if node.elements.empty?
		repository_element << "\t\t\tpatterns = ( { include = '#etc'; } );\n\t\t};\n"
		$repository << repository_element;
		return name
	end

	includes = []
	node.elements.each { |child|
		child_name = create_repository_groups(child,"#{scope}")
		includes << child_name unless child_name.nil?
	}

	unless includes.empty?
		repository_element << "\t\t\tpatterns = (\n"
		includes.uniq.each { |e|
			repository_element << "\t\t\t\t{ include = '##{e.sub('3','-three')}'; },\n" unless e.to_s.empty?
		}
		repository_element << "\t\t\t\t{ include = '#etc'; },\n"
		repository_element << "\t\t\t);\n"
	end

	repository_element << "\t\t};\n"

	$repository << repository_element;

	name

end

def trace_node(node,prefix='')

	puts prefix+node.name() #+node.attributes['append'].to_s
	return if node.elements.empty?
	node.elements.each { |child|
		trace_node(child,"#{prefix}\t")
	}
	puts prefix+node.name()

end

config = REXML::Document.new doc
create_repository_groups(config.root)
#trace_node(config.root)

grammar_path = "#{base_path}/../../Syntaxes/Flex Config.tmLanguage"
@grammar = OSX::PropertyList.load(File.read(grammar_path))

def add_group(str)
	group = OSX::PropertyList.load(str)
	@grammar['repository'].merge!(group)
end

$repository.uniq.each { |e| add_group(e) }

File.open(grammar_path, 'w') do |file|
  file << @grammar.to_plist
end

`osascript -e'tell app "TextMate" to reload bundles'`

puts "Complete"
