#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "fm/log"

class TestLog < Test::Unit::TestCase
  def test_log_location
    assert_equal("#{ENV['HOME']}/Library/Logs/TextMate\ ActionScript\ 3.log", FlexMate::Log.log_file)
  end

  def test_log_write
    log_msg = "Unit Test Test Text"
    FlexMate::Log.puts(log_msg)

    log_file = File.open(FlexMate::Log.log_file).readlines

    assert_match(/#{log_msg}$/, log_file.pop)
    assert_match(/.*TextMate::ActionScript 3.tmbundle$/, log_file.pop)
  end
end
