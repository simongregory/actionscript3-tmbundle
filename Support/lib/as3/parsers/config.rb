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

# Utility class convert a compiler config file into
# a list of it's properties.
#
class ConfigParser

  attr_accessor :flex_config

  def initialize(auto_find=false)
    @flex_config = FlexConfig.new

    if auto_find
      config_path = ConfigUtil.new.find
      if config_path
        load(File.new(config_path))
        @flex_config.file_path = config_path
      end
    end

  end

  def load(doc)

    require 'rexml/document'
    config = REXML::Document.new doc

    node = config.root
    add_root(node) if node.name() == 'flex-config'

  end

  def to_s
     s = ""
     flex_config.paths.each { |e| s << e.to_s }
     flex_config.namespaces.each { |e| s << e.to_s }
     s
  end

  def src_paths
    p = []
    flex_config.paths.each { |e| p << e.paths if e.type == 'source-path' }
    p.flatten.uniq
  end
  
  protected

  def add_root(node)
    node.elements.each { |child|
      if child.name() == 'compiler'
        add_compiler(child)
      end
    }
  end

  def add_compiler(node)

    node.elements.each { |child|
      name = child.name()
      if name =~ /(library-path|source-path|external-library-path)/
        flex_config.paths << PathElements.new(name,child)
      elsif name =~ /namespaces/
        add_namespaces(child)
      end
    }

  end

  def add_namespaces(node)
    node.elements.each { |child|
      name = child.name()
      if name =~ /namespace/
        flex_config.namespaces << Namespace.new(child)
      end
    }
  end

end

class ConfigUtil

  # Locate and return the compiler config file associated with the current
  # project.
  #
  def find
    build_file = ENV['TM_FLEX_FILE_SPECS'] || ''
    unless build_file.empty?
      cp = build_file.sub(/\.(as|mxml)$/,'')
      proj = ENV['TM_PROJECT_DIRECTORY']+'/' || ''
      return "#{proj}#{cp}-config.xml"
    end
    return nil
  end

end

class FlexConfig

  attr_accessor :namespaces
  attr_accessor :paths
  attr_accessor :file_path

  def initialize()
    @paths = []
    @namespaces = []
  end
  
  def manifest(uri)
    ns = @namespaces.find { |e| (e.uri == uri) }
    ns.manifest rescue nil
  end
  
  # Returns a list of classes for the given uri. The uri is cross referenced
  # with any known namespaces, if one isn't found then we *assume* that a 
  # package declaration has been given and check for classes in it's directory.
  #
  def class_list(uri)

    name = manifest(uri)
    c = []
    
    if name.nil?

      #At this point if we come across a uri containing a url it's likely 
      #that manifest is referenced in another document (ie the main flex 
      #config) - so ignore them.
      pkg_c = SourceTools.list_package(uri) if uri !~ /^http/
      
      #TODO: Warn the user no classes were found?
      c += pkg_c unless pkg_c.nil?
      
    else
      
      #TODO: Need to do some work here looking up the manifest file. For now this
      #use case expects the manifest to be in the root of src.
      manifest_uri = ENV['TM_PROJECT_DIRECTORY'] + "/src/" + name.to_s
      manifest_doc = IO.read(manifest_uri)
      m = Manifest.new(manifest_doc)
      
      c = m.classes
      
    end
    
    c
    
  end
  
end

class Namespace

  attr_accessor :uri
  attr_accessor :manifest

  def initialize(node)
    @uri = node.elements['uri'][0] rescue ''
    @manifest = node.elements['manifest'][0] rescue ''
  end

  def to_s
    "uri: #{uri}\nmanifest: #{manifest}"
  end

end

class PathElements

  attr_accessor :paths
  attr_reader :type

  def initialize(type,node)
    @type = type
    @paths = []
    node.elements.each { |child|
      if child.name() =~ /path-element/
        @paths << child[0]
      end
    }
  end

  def to_s
    "type: #{type}\npaths: #{@paths.join(' ')}\n"
  end

end

# if __FILE__ == $0
# 
# end
