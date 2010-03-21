#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "fm/settings"
require 'as3/source_tools'

class TestSettings < Test::Unit::TestCase

  def clear_tm_env
    ENV['TM_FLEX_FILE_SPECS'] = nil
    ENV['TM_PROJECT_FILEPATH'] = nil
    ENV['TM_PROJECT_DIRECTORY'] = nil
    ENV['TM_FLEX_OUTPUT'] = nil
    ENV['TM_FILEPATH'] = nil
  end

  def cases_dir
    File.expand_path(File.dirname(__FILE__)+'../../../../../Test/project')
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

  def test_is_air

    clear_tm_env

    s = FlexMate::Settings.new

    ENV['TM_PROJECT_DIRECTORY'] = cases_dir + '/a'

    assert_equal(false, s.is_air)

    ENV['TM_PROJECT_DIRECTORY'] = cases_dir + '/b'

    assert_equal(false, s.is_air)

    ENV['TM_PROJECT_DIRECTORY'] = cases_dir + '/c'

    assert_equal(false, s.is_air)

    ENV['TM_PROJECT_DIRECTORY'] = cases_dir + '/d'

    assert_equal(false, s.is_air)

    ENV['TM_PROJECT_DIRECTORY'] = cases_dir + '/e'

    assert_equal(true, s.is_air)

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

    #We intentionally don't consider the root of the project as a src dir.
    #TODO: Decide if we want it to be? Could be achieved by scanning root for
    #      .as or .mxml files.
    assert_equal(nil, s.source_path)

  end

end
