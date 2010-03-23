#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "fm/asd"

class TestASD < Test::Unit::TestCase
  def test_esc
    assert_equal("&amp;", FlexMate::ASD.esc("&"))
    assert_equal("&lt;", FlexMate::ASD.esc("<"))
  end
end

class TestLangReference < Test::Unit::TestCase
  def setup
    ENV['TM_FLEX_PATH'] = '/Developer/SDKs/flex_sdk_3.5.0'
    ENV['TM_BUNDLE_SUPPORT'] = File.dirname(__FILE__) + "/../../../"
  end
  
  def teardown
    ENV['TM_FLEX_PATH'] = ''
    ENV['TM_BUNDLE_SUPPORT'] = ''
  end
  
  def test_nothing
    #
  end
end

class TestFlexLangReference < TestLangReference
  def can_test
    path = ENV['TM_FLEX_PATH'] + '/docs/langref'
    path = ENV['TM_FLEX_PATH'] + '/asdoc-output' unless File.directory?(path)
    File.exist?(path)
  end
  
  def test_no_docs
    teardown
    w = "Sprite"
    r = FlexLangReference.new
    assert_equal("Flex SDK<p><ul><li>Flex SDK language reference not found.</li></ul></p>", r.search(w))
  end
  
  def test_single_hit_find
    c = 'AVM1Movie'
    r = FlexLangReference.new
    f = r.search(c)
    assert_match(/<b>#{c}<\/b> Found, redirecting\.\.\./, f)
    assert_match(/\/#{c}\.html/, f)
  end

  def test_unknown_find
    return unless can_test
    c = "FailToFindClass"
    r = FlexLangReference.new
    f = r.search(c)
    assert_match(/<ul><li>No results<\/li><\/ul>/, f)
  end

  def test_multiple_hit_find
    return unless can_test
    c = "Event"
    r = FlexLangReference.new
    f = r.search(c)
    assert_match(/Event\.html/, f)
    assert_match(/EventDispatcher\.html/, f)
    assert_match(/EventPhase\.html/, f)
  end
end

class TestFlashCS3LangReference < TestLangReference
  def can_test
    File.exist?('/Library/Application Support/Adobe/Flash CS3/en/Configuration/HelpPanel/help/ActionScriptLangRefV3')
  end
  
  def test_find
    r = FlashCS3LangReference.new
    f = r.search("Sprite")
    assert_equal("Flash CS3<p><ul><li>Flash CS3 language reference not found.</li></ul></p>", f)
  end
  
  def test_single_hit_find
    return unless can_test
    c = 'AVM1Movie'
    r = FlexLangReference.new
    f = r.search(c)
    assert_match(/<b>#{c}<\/b> Found, redirecting\.\.\./, f)
    assert_match(/\/#{c}\.html/, f)
  end

  def test_unknown_find
    return unless can_test
    c = "FailToFindClass"
    r = FlashCS3LangReference.new
    f = r.search(c)
    assert_match(/<ul><li>No results<\/li><\/ul>/, f)
  end

  def test_multiple_hit_find
    return unless can_test
    c = "Event"
    r = FlashCS3LangReference.new
    f = r.search(c)
    assert_match(/Event\.html/, f)
    assert_match(/EventDispatcher\.html/, f)
    assert_match(/EventPhase\.html/, f)
  end
end

class TestFlashCS4LangReference < TestLangReference
  def can_test
    File.exist?('/Library/Application Support/Adobe/Help/en_US/AS3LCR/Flash_10.0')
  end
  
  def test_single_hit_find
    c = "AVM1Movie"
    r = FlashCS4LangReference.new
    f = r.search(c)
    assert_match(/<b>#{c}<\/b> Found, redirecting\.\.\./, f)
    assert_match(/\/#{c}\.html/, f)
  end
  
  def test_unknown_find
    return unless can_test
    c = "FailToFindClass"
    r = FlashCS4LangReference.new
    f = r.search(c)
    assert_match(/<ul><li>No results<\/li><\/ul>/, f)
  end

  def test_multiple_hit_find
    return unless can_test
    c = "Event"
    r = FlashCS4LangReference.new
    f = r.search(c)
    assert_match(/Event\.html/, f)
    assert_match(/EventDispatcher\.html/, f)
    assert_match(/EventPhase\.html/, f)
  end
end
