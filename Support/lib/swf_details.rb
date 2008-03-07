#!/usr/bin/env ruby
#
# Copied from the TextMate HTML Bundle
#

require "zlib"

# Test for broken pack/unpack
if [1].pack('n') == "\001\000"
  class String
    alias_method :broken_unpack, :unpack
    def unpack(spec)
      broken_unpack(spec.tr("nNvV","vVnN"))
    end
  end
  class Array
    alias_method :broken_pack, :pack
    def pack(spec)
      broken_pack(spec.tr("nNvV","vVnN"))
    end
  end
end

class Swf
  
  @bits
  @width
  @height
  @version
  @bgcolor
  @buffer
  @zip
  @trace
  
  attr_reader :width
  attr_reader :height
  attr_reader :version
  attr_reader :bgcolor
  attr_reader :zip
  attr_reader :trace
  
  def initialize(f)
    @bits = ""
    
    @buffer = File.new(f,"r").read
    @zip = ("" << @buffer.slice(0)) == "C"
    @version = @buffer.slice(3).to_i
    
    #@trace = @buffer.slice(7)
    
    #Need to find out what we are cutting here.
    @buffer.slice!(0..7)
    
    if @zip
      @buffer = Zlib::Inflate.inflate(@buffer)
    end
    
    nbits = getBits(5)
    xmin = getBits(nbits)
    xmax = getBits(nbits)
    ymin = getBits(nbits)
    ymax = getBits(nbits)
    
    #mFrameRate = (float)swf.ReadByte() / 256;
    #mFrameRate += swf.ReadByte();
    
    @width = (xmax - xmin) / 20
    @height = (ymax - ymin) / 20
    
    @buffer.slice!(0..3)
    
    @bits = ""
    
    while(true)
		tag = getNextTag()

		# For an AS3 implementation:
		# http://flashpanoramas.com/blog/2007/07/02/swf-parser-air-application/		
		# There's also a C# version somewhere.
		
		# See http://the-labs.com/MacromediaFlash/SWF-Spec/SWFfilereference.html
		# For details of file format, id "Tag ID = 9" is Background Colour.
      
		if(tag[:id] == 9)
			@bgcolor = sprintf("#%02X%02X%02X", tag[:data][0], tag[:data][1], tag[:data][2])
			break
		elsif(tag[:id] == 39)
			# DefineSprite.
			break			
		elsif(tag[:id] == 43)
			# Frame Label, SWF 3 Only.
			break
		elsif(tag[:id] == 76)
			# SymbolClass.
			break						
		elsif(tag[:id] == 77)
			# Metadata.
			break
		end
    end
    
  end
  
private

  def getNextTag()
    tag_and_size = @buffer.slice!(0..1).unpack("v")[0]
    tag = {}
    tag[:id] = tag_and_size >> 6
    tag[:length] = tag_and_size & 0x3f
    if(tag[:length] == 63)
      tag[:length] = @buffer.slice!(0..3).unpack("V")[0]
    end
    
    tag[:data] = @buffer.slice!(0...tag[:length])
    return tag
  end
  
  def getBits(n)
    bytes = (n / 8.0).ceil
    (0...bytes).each {
      @bits << sprintf("%08b", @buffer.slice!(0))
    }
    out = @bits[0...n].to_i(2);
    @bits = @bits[n..-1]
    return out
  end
  
end

file = ENV["TM_DROPPED_FILE"]
name = file.match(/([^\/]+)\.swf$/)[1]
swf  = Swf.new(file)

print <<SWF
/*
filename	= "${1:#{name}.swf}"
width		= "#{swf.width}"
height		= "#{swf.height}"
version		= "#{swf.version}"
bgcolor		= "#{swf.bgcolor}"
compressed	= "#{swf.zip}"
*/
SWF