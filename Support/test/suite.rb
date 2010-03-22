#!/usr/bin/env ruby -wKU
# encoding: utf-8

require 'test/unit'

cases = File.dirname(__FILE__) + "/cases"

tests =  Dir["#{cases}/test_*.rb"]
tests << Dir["#{cases}/as3/test_*.rb"]
tests << Dir["#{cases}/as3/parsers/test_*.rb"]
tests << Dir["#{cases}/fm/test_*.rb"]

tests.flatten.each do |file|
  require file
end

#NOTE: Search for #flunk to expose tests yet to be written.

