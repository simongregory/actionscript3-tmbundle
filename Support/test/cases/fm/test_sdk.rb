#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "fm/sdk"

class TestSdk < Test::Unit::TestCase

  def has_sdk?
    File.exist?(test_sdk_path)
  end

  def test_sdk_path
    ENV['TM_FLEX_PATH'] || '/Developer/SDKs/flex_sdk_4.0.0'
  end

  def test_sdk_src_path
    "#{test_sdk_path}/frameworks/projects/framework/src"
  end

  def test_find_sdk
    return unless has_sdk?
    assert_equal(test_sdk_path, FlexMate::SDK.find_sdk.to_s)
  end

  def test_sdk_src
    return unless has_sdk?
    assert_equal(test_sdk_src_path, FlexMate::SDK.src)
  end

  def test_sdk_dir_list
    assert(FlexMate::SDK.sdk_dir_arr.length > 0, "SDK list should have contents")
  end

  def test_sdk_dir_arr
    assert(FlexMate::SDK.sdk_dir_list.length > 0, "SDK list should have contents")
  end

  def test_flex_config
    return unless has_sdk?
    assert(File.exist?(FlexMate::SDK.flex_config), "flex-config.xml file 404")
  end
end
