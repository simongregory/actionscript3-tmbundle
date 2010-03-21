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
require "as3/parsers/config"

class TestConfigParser < Test::Unit::TestCase

  def example_config
    '<flex-config>
    <compiler>
      <external-library-path>
          <path-element>../lib/actionscript/bin/framework.3.3.0.swc</path-element>
      </external-library-path>
      <source-path>
          <path-element>../lib/actionscript/springseed/src/</path-element>
      </source-path>
      <source-path append="true">
          <path-element>../lib/actionscript/layerglue/src/</path-element>
          <path-element>../lib/actionscript/puremvc/src/</path-element>
      </source-path>
      <source-path>
          <path-element>../lib/actionscript/papervision/src/</path-element>
      </source-path>
      <library-path append="true">
          <path-element>../resources/fla/components/</path-element>
      </library-path>
      <namespaces>
          <namespace>
              <uri>http://www.vw.co.uk/2009/vw/gti</uri>
              <manifest>GTI-manifest.xml</manifest>
          </namespace>
          <namespace>
              <uri>http://www.vw.co.uk/2009/vw/site</uri>
              <manifest>VW-manifest.xml</manifest>
          </namespace>
      </namespaces>
    </compiler>
    </flex-config>'
  end

  def test_case_name
    cp = ConfigParser.new(false)
    cp.load(example_config)

    find_paths = [ '../lib/actionscript/springseed/src/',
                   '../lib/actionscript/layerglue/src/',
                   '../lib/actionscript/puremvc/src/',
                   '../lib/actionscript/papervision/src/' ]

    found_paths = cp.src_paths
    find_paths.each { |p| assert(found_paths.include?(p), 'Missing Path') }
  end

end

class TestConfigUtil < Test::Unit::TestCase

  def test_find_mxml_config
    cu = ConfigUtil.new
    ENV['TM_FLEX_FILE_SPECS'] = 'src/Foo.mxml'
    proj = ENV['TM_PROJECT_DIRECTORY']+'/' || ''
    assert_equal("#{proj}src/Foo-config.xml", cu.find)
  end

  def test_find_as_config
    cu = ConfigUtil.new
    ENV['TM_FLEX_FILE_SPECS'] = 'src/Bar.as'
    proj = ENV['TM_PROJECT_DIRECTORY']+'/' || ''
    assert_equal("#{proj}src/Bar-config.xml", cu.find)
  end

end

