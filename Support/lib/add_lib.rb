#!/usr/bin/env ruby -wKU
# encoding: utf-8

# This adds our path to rubys lookup list. So wherever we require items from 
# this lib use:
# 
# require ENV['TM_BUNDLE_SUPPORT'] + '/lib/add_lib'
#
# Subsequently it is then possible to require like so:
#
# require 'fm/flex_mate'
#

$: << File.expand_path(File.dirname(__FILE__))
