#!/usr/bin/env ruby -wKU
# encoding: utf-8

require File.expand_path(File.dirname(__FILE__)) + '/../lib/fm/mxmlc_exhaust'

STDOUT.sync = true

ex = MxmlcExhaust.new
ARGF.each { |ln| ex.line(ln) }
ex.complete
