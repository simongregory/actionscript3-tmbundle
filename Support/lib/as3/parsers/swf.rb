#!/usr/bin/env ruby
# encoding: utf-8

# Copied from the TextMate HTML Bundle and under the TextMate license which can
# be found here http://svn.textmate.org/trunk/LICENSE

# Useful docs:
# http://www.adobe.com/devnet/swf/pdf/swf_file_format_spec_v10.pdf
# http://www.adobe.com/devnet/actionscript/articles/avm2overview.pdf

# AS3 implementations:
# http://github.com/claus/as3swf
# http://flashpanoramas.com/blog/2007/07/02/swf-parser-air-application/

# Other stuff
# There's a C# version in the FlashDevelop repository.
# Ming http://www.libming.org/
# Rubyamf http://code.google.com/p/rubyamf/

require "zlib"
#require "kconv" #have to do this to get toutf8 to work.

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

  attr_reader :file,
              :signature,
              :zip,
              :version,
              :file_length,
              :width,
              :height,
              :frame_rate,
              :frame_count,
              :bg_color,
              :bg_color_a,
              :metadata
  
  def to_s
     str = "\n\nfile: #{file}\n" +
           "signature: #{signature}\n" + 
           "version: #{version}\n" + 
           "file_length: #{file_length}\n" +
           "width: #{width}\n" +
           "height: #{height}\n" +
           "bg_color: #{bg_color}\n" +
           "frame_rate: #{frame_rate}\n" +
           "frame_count: #{frame_count}\n" +
           "metadata: #{metadata}\n"
     str
  end

  def initialize(f)
    
    #Switch to control if debugging output is printed during execution.
    @debug = false
    
    @bits = ""
    
    @file = File.basename(f)
    @buffer = File.new(f,"r").read
    
    @signature = "" << @buffer.slice!(0..2)
    
    raise "Wrong file type" unless @signature =~ /(C|F)WS/
    
    @zip = (@signature =~ /^C/)
    
    @version = @buffer.slice!(0).to_i
    
    @file_length = @buffer.slice!(0..3).unpack('v')[0]
    
    @buffer = Zlib::Inflate.inflate(@buffer) if @zip
    
    # Deal with our first 'Twip'
    nbits = getBits(5)
    xmin = getBits(nbits)
    xmax = getBits(nbits)
    ymin = getBits(nbits)
    ymax = getBits(nbits)
    
    @width = (xmax - xmin) / 20
    @height = (ymax - ymin) / 20
    
    @frame_rate = @buffer.slice!(0..1).unpack('v')[0] >> 8
    @frame_count = @buffer.slice!(0..1).unpack('v')[0]
    
    @bits = ""
    
    while(true)
      tag = getNextTag()
            
      id = tag[:id]
      log tag_name(id)
      
      if(id == 0)
        # End
        break
      elsif (id == 1)
        # ShowFrame
      elsif(id == 9)
        # Background Colour
        @bg_color = sprintf("#%02X%02X%02X", tag[:data][0], tag[:data][1], tag[:data][2])
        # Background Colour with Alpha
        @bg_color_a = @bg_color + sprintf("%02X", tag[:data][3])
      elsif(id == 69)
        # FileAttributes
        #puts tag[:data]
      elsif(id == 76)
        #SymbolClass.
        #data = tag[:data]
        #number_of_symbols = data.slice!(0..1).unpack('v')        
        #tag_id = data.slice!(0..1).unpack('v')
        #puts "No. of Tags: #{number_of_symbols}"
        #puts "First tag id: #{tag_id}"
      elsif(id == 77)
        # Metadata.
        xml = tag[:data][0..-2] #Am finding a null byte on the end, this drops it.
        xml = `echo "#{xml.gsub("\"", "\\\"")}" | xmllint --format -`
        @metadata = xml.to_s
      elsif (id == 82)
        #DoABC
        #abc = tag[:data]
      else
        log "id: #{id}"
      end
     
    end
    
  end
  
  private
  
  def getNextTag()
    
    tag_and_size = @buffer.slice!(0..1).unpack("v")[0]
    
    tag = {}
    tag[:id] = tag_and_size >> 6
    tag[:length] = tag_and_size & 0x3f
    
    if (tag[:length] == 63)
        tag[:length] = @buffer.slice!(0..3).unpack("V")[0]
    end
    
    tag[:data] = @buffer.slice!(0...tag[:length])
    
    return tag
  
  end
  
  def getBits(n)
    bytes = (n/8.0).ceil
    (0...bytes).each {
      @bits << sprintf("%08b", @buffer.slice!(0))
    }
    out = @bits[0...n].to_i(2);
    @bits = @bits[n..-1]
    return out
  end
  
  def tag_name(id)
    
    tags = {
      '0'  => 'End',
      '1'  => 'ShowFrame',
      '2'  => 'DefineShape',
      '4'  => 'PlaceObject',
      '5'  => 'RemoveObject',
      '6'  => 'DefineBits',
      '7'  => 'DefineButton',
      '8'  => 'JPEGTables',
      '9'  => 'SetBackgroundColor',
      '10' => 'DefineFont',
      '11' => 'DefineText',
      '12' => 'DoAction',
      '13' => 'DefineFontInfo',
      '14' => 'DefineSound',
      '15' => 'StartSound',
      '17' => 'DefineButtonSound',
      '18' => 'SoundStreamHead',
      '19' => 'SoundStreamBlock',
      '20' => 'DefineBitsLossless',
      '21' => 'DefineBitsJPEG2',
      '22' => 'DefineShape2',
      '23' => 'DefineButtonCxform',
      '24' => 'Protect',
      '26' => 'PlaceObject2',
      '28' => 'RemoveObject2',
      '32' => 'DefineShape3',
      '33' => 'DefineText2',
      '34' => 'DefineButton2',
      '35' => 'DefineBitsJPEG3',
      '36' => 'DefineBitsLossless2',
      '37' => 'DefineEditText',
      '39' => 'DefineSprite',
      '41' => 'ProductInfo',
      '43' => 'FrameLabel',
      '45' => 'SoundStreamHead2',
      '46' => 'DefineMorphShape',
      '48' => 'DefineFont2',
      '56' => 'ExportAssets',
      '57' => 'ImportAssets',
      '58' => 'EnableDebugger',
      '59' => 'DoInitAction',
      '60' => 'DefineVideoStream',
      '61' => 'VideoFrame',
      '62' => 'DefineFontInfo2',
      '63' => 'DebugID',
      '64' => 'EnableDebugger2',
      '65' => 'ScriptLimits',
      '66' => 'SetTabIndex',
      '69' => 'FileAttributes',
      '70' => 'PlaceObject3',
      '71' => 'ImportAssets2',
      '73' => 'DefineFontAlignZones',
      '74' => 'CSMTextSettings',
      '75' => 'DefineFont3',
      '76' => 'SymbolClass',
      '77' => 'Metadata',
      '78' => 'DefineScalingGrid',
      '82' => 'DoABC',
      '83' => 'DefineShape4',
      '84' => 'DefineMorphShape2',
      '86' => 'DefineSceneAndFrameLabelData',
      '87' => 'DefineBinaryData',
      '88' => 'DefineFontName',
      '89' => 'StartSound2',
      '90' => 'DefineBitsJPEG4',
      '91' => 'DefineFont4'
    }
    
    tags.fetch(id.to_s,nil)
    
  end
  
  def log(s)
    puts s if @debug
  end
  
end

# if __FILE__ == $0
#   
#   swf_file = '/path/to/test.swf'
#   swf  = Swf.new(swf_file)
#   puts swf.to_s
# 
# end