#!/usr/bin/env ruby -wKU
# encoding: utf-8

# Boolean to control whether or not UI Dialog boxes are presented during testing.
# $run_ui_tests = false;
#
# if $run_ui_tests
#   print "Select first element from each Menu for the tests to pass.\n\n"
# else
#   print "WARNING: Interactive UI Tests were skipped.\n\n"
# end

require "test/unit"
require "as3/source_tools"

class TestSourceTools < Test::Unit::TestCase

  # =========
  # = Setup =
  # =========

  def custom_src_dirs
    "foo:bar:baz"
  end

  def default_src_dirs
    "src:lib:source:test"
  end

  def bundle_src_dirs
    'intrinsic:air:flash_cs3:flash_ide'
  end

  def clean_env
    ENV['TM_AS3_USUAL_SRC_DIRS'] = nil
    ENV['TM_PROJECT_DIRECTORY'] = File.expand_path(File.dirname(__FILE__) + "/../../../../")
  end

  def run_ui_tests
    #$run_ui_tests
    false
  end

  def total_as_files
    493
  end
  
  # =========
  # = Tests =
  # =========

  def test_common_src_dir_list
    clean_env

    assert_equal(default_src_dirs, SourceTools.common_src_dir_list)

    ENV['TM_AS3_USUAL_SRC_DIRS'] = custom_src_dirs

    assert_equal(custom_src_dirs, SourceTools.common_src_dir_list)

  end

  def test_common_src_dirs
    clean_env

    assert_equal('src', SourceTools.common_src_dirs[0])

    ENV['TM_AS3_USUAL_SRC_DIRS'] = custom_src_dirs

    assert_equal('foo', SourceTools.common_src_dirs[0])
  end

  def test_search_project_paths

    clean_env

    require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'

    ENV['TM_AS3_USUAL_SRC_DIRS'] = bundle_src_dirs

    r = SourceTools.search_project_paths('Mov')

    assert_equal('flash.display.MovieClip', r[:partial_matches].to_s)
    assert_equal('', r[:exact_matches].to_s)

    r = SourceTools.search_project_paths('MovieClip')

    assert_equal('', r[:partial_matches].to_s)
    assert_equal('flash.display.MovieClip', r[:exact_matches].to_s)

    r = SourceTools.search_project_paths('Event')

    assert_equal('flash.events.EventDispatcher|flash.events.EventPhase', r[:partial_matches].join('|'))
    assert_equal('flash.events.Event', r[:exact_matches].to_s)

    r = SourceTools.search_project_paths('Math')

    assert_equal('', r[:partial_matches].to_s)
    assert_equal('Math', r[:exact_matches].to_s)

    r = SourceTools.search_project_paths('E')

    assert_equal(13, r[:partial_matches].length)
    assert_equal('', r[:exact_matches].to_s)

  end

  def test_search_bundle_paths

    clean_env

    r = SourceTools.search_bundle_paths('Mov')

    assert_equal('flash.display.MovieClip|mx.core.MovieClipAsset|mx.core.MovieClipLoaderAsset|mx.effects.Move|mx.effects.effectClasses.MoveInstance|mx.events.MoveEvent', r[:partial_matches].join('|'))
    assert_equal('', r[:exact_matches].to_s)

    r = SourceTools.search_bundle_paths('MovieClip')

    assert_equal('mx.core.MovieClipAsset|mx.core.MovieClipLoaderAsset', r[:partial_matches].join('|'))
    assert_equal('flash.display.MovieClip', r[:exact_matches].to_s)

    r = SourceTools.search_bundle_paths('Event')

    assert_equal('flash.events.EventDispatcher|flash.events.EventPhase|mx.core.EventPriority', r[:partial_matches].join('|'))
    assert_equal('flash.events.Event', r[:exact_matches].to_s)

    r = SourceTools.search_bundle_paths('Math')

    assert_equal('', r[:partial_matches].to_s)
    assert_equal('Math', r[:exact_matches].to_s)

    r = SourceTools.search_bundle_paths('E')

    assert_equal(23, r[:partial_matches].length)
    assert_equal('', r[:exact_matches].to_s)

  end

  def test_search_all_paths

    clean_env

    ENV['TM_AS3_USUAL_SRC_DIRS'] = bundle_src_dirs

    r = SourceTools.search_all_paths('Mov')

    assert_equal('flash.display.MovieClip|mx.core.MovieClipAsset|mx.core.MovieClipLoaderAsset|mx.effects.Move|mx.effects.effectClasses.MoveInstance|mx.events.MoveEvent', r[:partial_matches].join('|'))
    assert_equal('', r[:exact_matches].to_s)

    r = SourceTools.search_all_paths('MovieClip')

    assert_equal('mx.core.MovieClipAsset|mx.core.MovieClipLoaderAsset', r[:partial_matches].join('|'))
    assert_equal('flash.display.MovieClip', r[:exact_matches].to_s)

    r = SourceTools.search_all_paths('Event')

    assert_equal('flash.events.EventDispatcher|flash.events.EventPhase|mx.core.EventPriority', r[:partial_matches].join('|'))
    assert_equal('flash.events.Event', r[:exact_matches].to_s)

    r = SourceTools.search_all_paths('Math')

    assert_equal('', r[:partial_matches].to_s)
    assert_equal('Math', r[:exact_matches].to_s)

    r = SourceTools.search_all_paths('E')

    assert_equal(26, r[:partial_matches].length)
    assert_equal('', r[:exact_matches].to_s)

  end

  def test_truncate_to_src
    clean_env

    p = 'a/b/src/com'
    assert_equal('com', SourceTools.truncate_to_src(p))

    p = '/a/b/source/c/src/test/org/helvector/io'
    assert_equal('org/helvector/io', SourceTools.truncate_to_src(p))

    p = '/a/b/source/org/helvector/io'
    assert_equal('org/helvector/io', SourceTools.truncate_to_src(p))

  end

  def test_find_package

    clean_env

    require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
    require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

    ENV['TM_AS3_USUAL_SRC_DIRS'] = bundle_src_dirs

    assert_equal('VerifyError', SourceTools.find_package('VerifyError'))
    assert_equal('flash.data.SQLSchemaResult', SourceTools.find_package('SQLSchemaResult'))

    # When you get the UI menu select the first item in the list.
    if run_ui_tests
      assert_equal('flash.display.MovieClip', SourceTools.find_package('Mov'))
      assert_equal('flash.data.SQLCollationType', SourceTools.find_package('SQL'))
    end

  end

  def test_list_package

    clean_env

    p = ENV['TM_PROJECT_DIRECTORY'] + '/Support/data/completions/intrinsic/flash/display'
    c = SourceTools.list_package(p)

    assert_equal(c.include?('MovieClip'), true)
    assert_equal(c.length, 33)

    p = ENV['TM_PROJECT_DIRECTORY'] + '/Support/data/completions/intrinsic/flash/accessibility'
    c = SourceTools.list_package(p)

    assert_equal(c.length, 2)
  end

  def test_list_all_class_files
    clean_env

    require 'find'

    ENV['TM_AS3_USUAL_SRC_DIRS'] = bundle_src_dirs

    c = SourceTools.list_all_class_files

    assert_equal(true, c.include?('Boolean.as'))
    assert_equal(total_as_files, c.length)
  end

  def test_list_all_classes
    clean_env

    require 'find'

    ENV['TM_AS3_USUAL_SRC_DIRS'] = bundle_src_dirs

    c = SourceTools.list_all_classes

    assert_equal(c.include?('Boolean'), true)
    assert_equal(total_as_files, c.length)

  end

end
