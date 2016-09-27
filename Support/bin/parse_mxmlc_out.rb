#!/usr/bin/env ruby18 -wKU
# encoding: utf-8

#NOTE: Keep for legacy reasons. Users could be using this to pipe output to.

require File.expand_path(File.dirname(__FILE__)) + '/../lib/fm/mxmlc_exhaust'

STDOUT.sync = true

ex = MxmlcExhaust.new
ARGF.each { |ln| ex.line(ln) }
ex.complete
