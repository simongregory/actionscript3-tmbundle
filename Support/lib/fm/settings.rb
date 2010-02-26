#!/usr/bin/env ruby -wKU
# encoding: utf-8

module FlexMate
  
  # Utility methods for collecting ActionScript 3/Flex specific environmental
  # settings.
  #
  class Settings
    
    # By default the bundle assumes that the env variable TM_PROJECT_DIRECTORY 
    # points to the root directory of the flex/actionscript project. However TM
    # sets the value based on the closest file to the root of the filesystem. To
    # combat this, and enable users to collect files from places outside of the
    # normal project we also check the location of the 'tmproj' file and assume
    # that if there is one, it has been placed in the root of the
    # flex/actionscript project.
    #
    def proj_root

      proj_file = ENV['TM_PROJECT_FILEPATH'] || ''
      proj_dir = ENV['TM_PROJECT_DIRECTORY'] || ''
      
      return File.dirname(proj_file) unless proj_file.empty?
      return proj_dir unless proj_dir.empty?
      return ''
      
    end
    
    # Inspects the available environmental variables and gathers the settings
    # necessary for the compiler to run.
    #
    def file_specs
      
      proj_dir = proj_root
      file_specs = ENV['TM_FLEX_FILE_SPECS']
      
      return file_specs if file_specs && File.exist?(file_specs)

      if proj_dir && file_specs
        file_specs = proj_dir + '/' + file_specs
        return file_specs if File.exist?(file_specs)
      end

      if proj_dir
        file_specs = guess_file_specs(proj_dir)
        return file_specs unless file_specs.nil?
      end

      file_specs = ENV['TM_FILEPATH']

    end

    # When TM_FLEX_OUTPUT and TM_PROJECT_DIRECTORY are defined use them to
    # build flex output. Otherwise derive the output from the file specs.
    #
    def flex_output

      flex_output = ENV['TM_FLEX_OUTPUT']
      
      proj_dir = proj_root
      
      # As this could be called more than once, and the value of TM_FLEX_OUTPUT
      # stands a chance of being set in between, we need to make sure that we
      # dont unecessarily prepend the proj_dir.
      if flex_output && proj_dir
        return flex_output if flex_output.include? proj_dir 
        return proj_dir + '/' + flex_output
      end

      fx_out = file_specs.sub(/\.(mxml|as)/, ".swf")
      
      if !proj_dir.empty? && File.exist?( proj_dir.to_s + '/bin' )
        #match src backwards from the end of line. This covers us in these
        #cases foo/src/bar/src/class.
        sd = SourceTools.common_src_dir_list.reverse.gsub(':','|')
        fx_out.reverse!.sub!(/(#{sd})/,'nib').reverse!
      end

      fx_out

    end

    # Locate and return the compiler config file associated with the current
    # project.
    #
    def compiler_config
      build_file = ENV['TM_FLEX_FILE_SPECS'] || ''
      unless build_file.empty?
        cp = build_file.sub(/\.(as|mxml)$/,'')
        proj = proj_root+'/' || ''
        return "#{proj}#{cp}-config.xml"
      end
      return nil
    end
    
    # Boolean to indicate if we are compiling a swc instead of a swf.
    #
    def is_swc
      return true if flex_output =~ /\.swc/ rescue false
      return false
    end
    
    # A list of classes found in the project.
    #
    def list_classes
      SourceTools.list_all_classes.join(' ')
    end

    # Locates the first conventional src path found.
    #
    def source_path
      pr = proj_root
      SourceTools.common_src_dirs.each do |d| 
        return "#{pr}/#{d}" if File.directory?("#{pr}/#{d}")
      end
      nil
    end
    
    protected
    
    # Where we have Project Directory but no TM_FLEX_FILE_SPECS set take a look
    # inside the src/ dir and see if we can work out which file should be
    # compiled.
    #
    def guess_file_specs(proj_dir)

      possible_src_dirs = SourceTools.common_src_dirs
      
      #Additionally check the root of the project
      possible_src_dirs.push('')
      
      src_dir = ""
      fs = []

      possible_src_dirs.each do |d|

        src_dir = d.empty? ? proj_dir : proj_dir + '/' + d

        if File.exist?(src_dir)

          Dir.foreach(src_dir) do |f|
            fs << src_dir + '/' + f if f =~ /\.(as|mxml)$/
          end

        end

      end

      #TODO: Where multiple matches are found, should we
      #
      #   * Default to the first in the list.
      #   * Present a list of files to compile to the user to choose from.
      #   * Check TM_FILEPATH to see if it's sat in src or test and compile accordingly.
      #
      return fs[0] unless fs[0] == nil

    end

  end
  
end

if __FILE__ == $0

  require "test/unit"
  require "../as3/source_tools"
  
  class TestSettings < Test::Unit::TestCase
    
    def clear_tm_env
      ENV['TM_FLEX_FILE_SPECS'] = nil
      ENV['TM_PROJECT_FILEPATH'] = nil
      ENV['TM_PROJECT_DIRECTORY'] = nil
      ENV['TM_FLEX_OUTPUT'] = nil
      ENV['TM_FILEPATH'] = nil
    end
    
    def cases_dir
      File.expand_path(File.dirname(__FILE__)+'../../../../Test/project')
    end
    
    def test_proj_root
      
      clear_tm_env
      
      s = FlexMate::Settings.new
      
      ENV['TM_PROJECT_DIRECTORY'] = '/foo/bar/project'
      
      assert_equal('/foo/bar/project', s.proj_root)
      
      ENV['TM_PROJECT_FILEPATH'] = '/foo/bar/project/test.tmproj'
      ENV['TM_PROJECT_DIRECTORY'] = '/foo/bar/project'
      
      assert_equal('/foo/bar/project', s.proj_root )
      
      ENV['TM_PROJECT_FILEPATH'] = nil
      ENV['TM_PROJECT_DIRECTORY'] = nil
      
      assert_equal('', s.proj_root )
      
    end
    
    def test_compiler_config
      
      clear_tm_env

      ENV['TM_PROJECT_DIRECTORY'] = '/Foo/Bar/TestProject'
      ENV['TM_FLEX_FILE_SPECS'] = 'src/Test.as'
      
      assert_equal('/Foo/Bar/TestProject/src/Test-config.xml', 
                   FlexMate::Settings.new.compiler_config)
      
      ENV['TM_FLEX_FILE_SPECS'] = 'src/Test.mxml'
      
      assert_equal('/Foo/Bar/TestProject/src/Test-config.xml',
                   FlexMate::Settings.new.compiler_config)
      
      ENV['TM_PROJECT_FILEPATH'] = '/Foo/Bar/TestProject/baz.tmproj'
      
      assert_equal('/Foo/Bar/TestProject/src/Test-config.xml',
                    FlexMate::Settings.new.compiler_config)
      
    end
    
    def test_file_specs
      clear_tm_env
            
      s = FlexMate::Settings.new
      
      ENV['TM_PROJECT_DIRECTORY'] = p = cases_dir + '/a'
      assert_equal(p + '/src/App.mxml', s.file_specs)
      
      ENV['TM_PROJECT_DIRECTORY'] = p = cases_dir + '/b'
      assert_equal(p + '/source/App.as', s.file_specs )

      ENV['TM_PROJECT_DIRECTORY'] = p = cases_dir + '/c'
      assert_equal(p + '/App.as', s.file_specs )

      ENV['TM_PROJECT_DIRECTORY'] = p = cases_dir + '/d'
      assert_equal(p + '/src/App.as', s.file_specs )
      
      clear_tm_env

      #NOTE: These are expected to be nil because they do not resolve to a file.
      ENV['TM_PROJECT_DIRECTORY'] = '/foo/bar/project'
      assert_equal(nil, s.file_specs)

      ENV['TM_FLEX_FILE_SPECS'] = 'abc/Test.as'
      assert_equal(nil, s.file_specs)

    end
    
    def test_flex_output

      clear_tm_env
            
      s = FlexMate::Settings.new
      
      ENV['TM_PROJECT_DIRECTORY'] = p = cases_dir + '/a'
      assert_equal(p + '/src/App.swf', s.flex_output)
      
      ENV['TM_PROJECT_DIRECTORY'] = p = cases_dir + '/b'      
      assert_equal(p + '/source/App.swf', s.flex_output )

      ENV['TM_PROJECT_DIRECTORY'] = p = cases_dir + '/c'
      assert_equal(p + '/App.swf', s.flex_output )

      ENV['TM_PROJECT_DIRECTORY'] = p = cases_dir + '/d'
      assert_equal(p + '/bin/App.swf', s.flex_output )
      
      clear_tm_env
      
      ENV['TM_PROJECT_DIRECTORY'] = '/foo/bar/project'
      ENV['TM_FLEX_OUTPUT'] = 'abc/Test.swf'
      
      assert_equal('/foo/bar/project/abc/Test.swf', s.flex_output)

      clear_tm_env
      
      ENV['TM_PROJECT_DIRECTORY'] = '/foo/bar/pro ject'
      ENV['TM_FLEX_OUTPUT'] = 'abc/Test.swf'
      
      assert_equal('/foo/bar/pro ject/abc/Test.swf', s.flex_output)
      
      ENV['TM_FLEX_OUTPUT'] = s.flex_output
      
      assert_equal('/foo/bar/pro ject/abc/Test.swf', s.flex_output)
      
    end
    
    def test_is_swc
      
      clear_tm_env
      
      s = FlexMate::Settings.new
      
      ENV['TM_PROJECT_DIRECTORY'] = '/foo/bar/project'
      ENV['TM_FLEX_OUTPUT'] = 'abc/Test.swc'
      
      assert_equal(true, s.is_swc)
      
      clear_tm_env
      
      ENV['TM_PROJECT_DIRECTORY'] = '/foo/bar/pro ject'
      ENV['TM_FLEX_OUTPUT'] = 'abc/Test.swf'
      
      assert_equal(false, s.is_swc)
      
      clear_tm_env
      
      assert_equal(false, s.is_swc)
      
      
    end 
    
    def test_source_path
      
      clear_tm_env
      
      s = FlexMate::Settings.new
      
      assert_equal(nil, s.source_path)
      
      clear_tm_env
      
      ENV['TM_PROJECT_DIRECTORY'] = cases_dir + '/a'
      
      assert_equal(cases_dir + '/a/src', s.source_path)
      
      clear_tm_env
      
      ENV['TM_PROJECT_DIRECTORY'] = cases_dir + '/b'
      
      assert_equal(cases_dir + '/b/source', s.source_path)
      
      clear_tm_env
      
      ENV['TM_PROJECT_DIRECTORY'] = cases_dir + '/c'
      
      assert_equal(cases_dir, s.source_path)
      
    end
    
  end
  
end
