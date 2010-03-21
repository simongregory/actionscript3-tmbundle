#!/usr/bin/env ruby
# encoding: utf-8

################################################################################
#
#   Copyright 2009 Simon Gregory
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
################################################################################

# A object representing the information on class members found within a
# mxml document.
#
# This is work in progress and parsing only looks at any xml in the document (script
# tags are ignored).
#
class MxmlDoc

  attr_accessor :super_class
  attr_accessor :super_namespace
  attr_accessor :namespaces
  attr_accessor :properties

  def initialize(doc)
    require 'rexml/document'
    @source = REXML::Document.new doc

    @super_class = @source.root.name
    @super_namespace = @source.root.namespace
    @properties = []
    
    parse_namespaces
    
    @script = ""

    add_members(@source.root)
  end

  def to_s
    s = []
    s << "super_class: #{super_class}\n"
    s << "super_namespace: #{@super_namespace}\n\n"
    s << "namespaces: #{@namespaces}\n\n"
    properties.each { |e| s << e.to_s + "\n\n" }
    s << "Script:\n#{@script}"
    s.to_s
  end
  
  def get_namespace_with_prefix(id)
    @namespaces.find { |ns| (ns[:prefix] == id) }
  end
  
  # Boolean indicating wether or not the document has a default namesapce 
  # specified.
  #
  def using_default_namespace
    return true if get_namespace_with_prefix('')
    false
  end
  
  def default_namespace_uri
    get_namespace_with_prefix('')[:name]
  end
  
  protected

  # Currently adds all properties found in the XML portion of the document. This
  # should be expanded to include methods, etc.
  #
  def add_members(node)

    if node.name() == 'Script'
      @script << "#{node.children.to_s}\n"
    elsif node.attributes['id']
      properties << MemberToken.new(node.attributes['id'], node.name,node.namespace)
    end

    node.elements.each { |child|
        add_members(child)
    }

  end
  
  # Lists all the namespaces defined in the root node of doc.
  #
  def parse_namespaces
    
    @namespaces = []
    
    @source.root.namespaces.each { |ns|
      pf = ( ns[0]  == 'xmlns' ) ? '' : ns[0]
      nm = ns[1]
      @namespaces << { :prefix => pf, :name => nm, }
    }
    
    #ns_regexp = /xmlns:?(\w+)?=([\'\"])([\w.*\/:]+)([\'\"])/
    #ns = []
    #doc.each { |line| 
    #  if line =~ ns_regexp
    #    ns << { :prefix => "#{$1}", :name => $2, }
    #    puts $1
    #  end
    #}
    
    # @namespaces = ns.uniq
    
  end
  
end

# Class member token.
#
class MemberToken

  attr_accessor :name
  attr_accessor :type
  attr_accessor :signature
  attr_accessor :ns

  def initialize(name,type,ns='',signature='')
    @name = name
    @type = type
    @signature = signature
    @ns = ns
  end

  def to_s
    "Name:#{name} Type:#{type} Namespace:#{ns}"
  end

end

# if __FILE__ == $0
#   
# end
