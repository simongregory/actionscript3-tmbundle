#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "fm/flex_mate"

class TestFlexMate < Test::Unit::TestCase
  def test_snippetize_method_params
    params = [
      "method(one:Number)",
      "method(one:Number,two:String,three:*, four:Test=10, ...rest)",
      "method(one:Number,
        two:String,
        three:*,
        four:Test, ...rest);",
      "method(zero:Number,four:String='chalk',six:String=BIG_EVENT,three:Boolean=true)",
      "method(zero:Number,four:String=\"chalk\",six:String=BIG_EVENT,three:Boolean = true)",]

    assert_equal('method(${1:one:Number})',FlexMate.snippetize_method_params(params[0]))
    assert_equal('method(${1:one:Number},${2:two:String},${3:three:*},${4:four:Test=10},${5:...rest})',FlexMate.snippetize_method_params(params[1]))
    assert_equal('method(${1:one:Number},${2:two:String},${3:three:*},${4:four:Test},${5:...rest});',FlexMate.snippetize_method_params(params[2]))
    assert_equal('method(${1:zero:Number},${2:four:String=\'chalk\'},${3:six:String=BIG_EVENT},${4:three:Boolean=true})',FlexMate.snippetize_method_params(params[3]))
    assert_equal('method(${1:zero:Number},${2:four:String="chalk"},${3:six:String=BIG_EVENT},${4:three:Boolean=true})',FlexMate.snippetize_method_params(params[4]))

  end
    
end