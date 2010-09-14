#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "fm/compiler"
require "c_env"

class MockSettings
  attr_reader :flex_output,
              :file_specs,
              :list_classes,
              :source_path,
              :is_swc,
              :is_air

  def initialize
    @project_path = "/a/project"
    setup
  end

  def setup
    @flex_output = "#{@project_path}/bin/Test.swf"
    @file_specs = "#{@project_path}/src/Test.as"
    @list_classes = "flash/display/DisplayObject.as flash/display/CapsStyle.as flash/display/BlendMode.as"
    @source_path = "#{@project_path}/additional_src"
    @is_air = false
    @is_swc = false
  end

  def set_paths_that_need_escaping
    @project_path = '/a b/pro ject'
    setup
  end
end

class TestMxmlcCommand < Test::Unit::TestCase
  def test_mxmlc_line
    s = MockSettings.new
    c = MxmlcCommand.new(s)

    assert_equal('mxmlc -file-specs=/a/project/src/Test.as -o=/a/project/bin/Test.swf', c.line)
  end

  def test_mxmlc_escaping_line
    s = MockSettings.new
    s.set_paths_that_need_escaping
    c = MxmlcCommand.new(s)

    assert_equal('mxmlc -file-specs=/a\\ b/pro\\ ject/src/Test.as -o=/a\\ b/pro\\ ject/bin/Test.swf', c.line)
  end
end

class TestAMxmlcCommand < Test::Unit::TestCase
  def test_amxmlc_line
    s = MockSettings.new
    c = AMxmlcCommand.new(s)

    assert_equal('mxmlc +configname=air -file-specs=/a/project/src/Test.as -o=/a/project/bin/Test.swf', c.line)
  end

  def test_amxmlc_escaping_line
    s = MockSettings.new
    s.set_paths_that_need_escaping
    c = AMxmlcCommand.new(s)

    assert_equal('mxmlc +configname=air -file-specs=/a\\ b/pro\\ ject/src/Test.as -o=/a\\ b/pro\\ ject/bin/Test.swf', c.line)
  end
end

class TestCompcCommand < Test::Unit::TestCase
  def test_compc_line
    s = MockSettings.new
    c = CompcCommand.new(s)

    assert_equal('compc -source-path+=/a/project/additional_src -o=/a/project/bin/Test.swf flash/display/DisplayObject.as flash/display/CapsStyle.as flash/display/BlendMode.as', c.line)
  end

  def test_compc_escaping_line
    s = MockSettings.new
    s.set_paths_that_need_escaping
    c = CompcCommand.new(s)

    assert_equal('compc -source-path+=/a\\ b/pro\\ ject/additional_src -o=/a\\ b/pro\\ ject/bin/Test.swf flash/display/DisplayObject.as flash/display/CapsStyle.as flash/display/BlendMode.as', c.line)
  end
end

# class TestCompiler < Test::Unit::TestCase
# end

# class TestFcshCompiler < Test::Unit::TestCase
# end
