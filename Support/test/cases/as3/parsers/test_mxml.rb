#!/usr/bin/env ruby
# encoding: utf-8

################################################################################
#
#   Copyright 2009-2010 Simon Gregory
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

require "test/unit"
require "as3/parsers/mxml"

class TestMxmlDoc < Test::Unit::TestCase

  def example_mxml
    '<?xml version="1.0" encoding="utf-8"?>
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
  end

  def find_item(a,id)
    t = a.select {|o| o.name == id }
    t[0]
  end

  def test_super_class
    mxp = MxmlDoc.new(example_mxml)
    assert_equal("GTIApplication", mxp.super_class)
  end

  def test_super_namespace
    mxp = MxmlDoc.new(example_mxml)
    assert_equal("http://www.vw.co.uk/2009/vw/gti", mxp.super_namespace)
  end

  def test_namespaces
    mxp = MxmlDoc.new(example_mxml)
    assert_equal(3, mxp.namespaces.length)
    assert_equal('http://www.vw.co.uk/2009/vw/gti', mxp.get_namespace_with_prefix('vw')[:name])
    assert_equal('http://www.adobe.com/2006/mxml', mxp.get_namespace_with_prefix('')[:name])
    assert_equal('http://www.adobe.com/2006/mxml', mxp.default_namespace_uri)
    assert_equal('uk.co.vw.test.*', mxp.get_namespace_with_prefix('test')[:name])
    assert_equal(true,mxp.using_default_namespace)
  end

  def test_properties
    mxp = MxmlDoc.new(example_mxml)
    assert_equal(4, mxp.properties.length)

    tok = find_item(mxp.properties, 'underlay')
    assert_equal('underlay', tok.name)
    assert_equal('Canvas', tok.type)
    assert_equal('http://www.adobe.com/2006/mxml', tok.ns)

    tok = find_item(mxp.properties, 'siteView')
    assert_equal('siteView', tok.name)
    assert_equal('SiteView', tok.type)
    assert_equal('http://www.vw.co.uk/2009/vw/gti', tok.ns)

    tok = find_item(mxp.properties, 'dialogContainer')
    assert_equal('dialogContainer', tok.name)
    assert_equal('DialogContainer', tok.type)
    assert_equal('http://www.vw.co.uk/2009/vw/gti', tok.ns)

    tok = find_item(mxp.properties, 'test')
    assert_equal('test', tok.name)
    assert_equal('Box', tok.type)
    assert_equal('uk.co.vw.test.*', tok.ns)

  end

end
