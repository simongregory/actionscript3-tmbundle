#!/usr/bin/env ruby -wKU

# Downloads and installs flex to a default location used by TextMate.

require 'open-uri'

flex_uri = "http://download.macromedia.com/pub/flex/sdk/flex_sdk_3.zip"
flex_help_uri = "http://livedocs.adobe.com/flex/3/flex3_documentation.zip"

open("/Users/simon/Desktop/flex_sdk_3.zip","w").write(open(flex_uri).read)
open("/Users/simon/Desktop/flex_help.zip","w").write(open(flex_help_uri).read)
