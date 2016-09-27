#!/usr/bin/env ruby18
# encoding: utf-8

require "test/unit"
require "as3/parsers/swf"

class TestSwf < Test::Unit::TestCase
  def swf_path
    File.dirname(__FILE__) + "/../../../assets/swf/Simple.swf"
  end

  def test_swf_output
    swf  = Swf.new(swf_path)

    assert_equal('Simple.swf', swf.file)
    assert_equal('CWS', swf.signature)
    assert_equal(9, swf.version)
    assert_equal(827, swf.file_length)
    assert_equal(600, swf.width)
    assert_equal(401, swf.height)
    assert_equal('#000000', swf.bg_color)
    assert_equal(60, swf.frame_rate)
    assert_equal(1, swf.frame_count)
    assert_equal(true, swf.zip)
  end
end