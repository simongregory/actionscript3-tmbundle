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
# This is work in progress and parsing on looks at any xml in the document (script
# tags are ignored).
#
class MxmlDoc

  attr_accessor :super_class
  attr_accessor :properties

  def initialize(doc)
    require 'rexml/document'
    @source = REXML::Document.new doc

    @super_class = @source.root.name
    @super_namespace = @source.root.namespace
    @properties = []

    @mxml_ns = "http://www.adobe.com/2006/mxml"
    @script = ""

    add_members(@source.root)
  end

  def to_s
    s = []
    s << "super_class: #{super_class}\n"
    s << "super_namespace: #{@super_namespace}\n\n"
    properties.each { |e| s << e.to_s + "\n\n" }
    s << "Script:\n#{@script}"
    s.to_s
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

if __FILE__ == $0

  doc = '<?xml version="1.0" encoding="utf-8"?>
<vw:GTIApplication
    xmlns="http://www.adobe.com/2006/mxml"
    xmlns:vw="http://www.vw.co.uk/2009/vw/gti"
    xmlns:test="uk.co.vw.test.*">

    <Style source="/../resources/style/main.css" />

    <Script><![CDATA[import uk.co.vw.foo.Bar;]]></Script>
    <Script>import uk.co.vw.bar.Foo;</Script>

    <vw:SiteView id="siteView" />

    <vw:DialogContainer id="dialogContainer" />

    <Canvas id="underlay"/>

    <test:Box id="test" />

</vw:GTIApplication>'

  mxp = MxmlDoc.new(doc)
  puts mxp.to_s

end