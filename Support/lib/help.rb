#!/usr/bin/env ruby -wKU
# encoding: utf-8

# Generates the ActionScript 3 Bundle help document. 
# Takes the help.mdown doc and injects the list of paths searched
# when bundle items attempt to locate the flex sdk.

BUNDLE_SUPPORT_LIB = File.expand_path(File.dirname(__FILE__))

require BUNDLE_SUPPORT_LIB + '/fm/sdk'

paths = ""
FlexMate::SDK.sdk_dir_arr.each{ |e| paths << "* \`#{e}\`\n" }

doc = IO.read(BUNDLE_SUPPORT_LIB+'/../../help.mdown')

print doc.sub('${FLEX-PATH-LIST}', paths )
