#!/usr/bin/env ruby
# encoding: utf-8

################################################################################
#
#		Copyright 2009 Simon Gregory
#		
#		This program is free software: you can redistribute it and/or modify
#		it under the terms of the GNU General Public License as published by
#		the Free Software Foundation, either version 3 of the License, or
#		(at your option) any later version.
#		
#		This program is distributed in the hope that it will be useful,
#		but WITHOUT ANY WARRANTY; without even the implied warranty of
#		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#		GNU General Public License for more details.
#		
#		You should have received a copy of the GNU General Public License
#		along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
################################################################################

# STUB

# Utility class convert a compiler config file into
# a list of it's properties.
#
class ConfigParser
  def initialize()    
  end
  
  def load(doc)
    puts doc
  end
  
end

class ConfigUtil
  
  # Locate and return the compiler config file associated with the current 
  # project.
  #
  def find
    
  end
end

class ConfigDoc
  def initialize(args)
    
  end
  
  attr_accessor :external_lib_paths
  attr_accessor :src_paths
  attr_accessor :lib_paths
  attr_accessor :namespaces
    
end

class PathToken
  
end

class NamespaceToken
  
end

if __FILE__ == $0

  test_config = '<flex-config>
  <compiler>  
    <external-library-path>
        <path-element>../lib/actionscript/bin/framework.3.3.0.swc</path-element>
    </external-library-path>
    <source-path append="true">
        <path-element>../lib/actionscript/layerglue/src/</path-element>
        <path-element>../lib/actionscript/puremvc/src/</path-element>          
    </source-path>
    <library-path append="true">
        <path-element>../resources/fla/components/</path-element>
    </library-path>
    <namespaces>
        <namespace>
            <uri>http://www.vw.co.uk/2009/vw/gti</uri>
            <manifest>GTI-manifest.xml</manifest>
        </namespace>
    </namespaces>
  </compiler>
</flex-config>'

  cp = ConfigParser.new
  cp.load(test_config)
end