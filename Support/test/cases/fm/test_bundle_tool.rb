#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "fm/bundle_tool"

class TestBundleTool < Test::Unit::TestCase
  def user
    ENV['USER']
  end

  def user_app_sup
    "/Users/#{user}/Library/Application Support"
  end

  def test_find_without_extension
    assert_equal("#{user_app_sup}/TextMate/Bundles/Flex.tmbundle", FlexMate::BundleTool.find_bundle('Flex')[0])
    assert_equal("#{user_app_sup}/TextMate/Bundles/ActionScript 3.tmbundle", FlexMate::BundleTool.find_bundle('ActionScript 3')[0])
  end

  def test_find_with_extension
    assert_equal("#{user_app_sup}/TextMate/Bundles/Flex.tmbundle", FlexMate::BundleTool.find_bundle('Flex.tmbundle')[0])
    assert_equal("#{user_app_sup}/TextMate/Bundles/ActionScript 3.tmbundle", FlexMate::BundleTool.find_bundle('ActionScript 3.tmbundle')[0])
  end
end
