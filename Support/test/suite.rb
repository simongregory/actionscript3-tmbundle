#!/usr/bin/env ruby -wKU
# encoding: utf-8

require 'test/unit'

# NOTE: The tests need to pick up the relevant tm ruby lib files from the
# TextMate support directory so invoke the suite from within TM using Apple-R
# (and have the Ruby bundle enabled).
#
# Individual test can be targeted in the same way, just open the file and use
# Apple-R, or Apple-Shift-R.

cases = File.dirname(__FILE__) + "/cases"

tests =  Dir["#{cases}/test_*.rb"]
tests << Dir["#{cases}/as3/test_*.rb"]
tests << Dir["#{cases}/as3/parsers/test_*.rb"]
tests << Dir["#{cases}/fm/test_*.rb"]

tests.flatten.each do |file|
  require file
end
