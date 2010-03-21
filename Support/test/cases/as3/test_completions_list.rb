#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "as3/completions_list"

class MockClassParser
  attr_accessor :properties, :gettersetters, :methods
  attr_accessor :static_properties, :static_methods
  attr_accessor :effects, :events, :styles
end

class TestCompletionsList < Test::Unit::TestCase

  def test_dialog

    c = MockClassParser.new
    c.properties = [ "testProperty" ]
    c.gettersetters = [ "testGetter", nil ]
    c.methods = [ 'paramaterless():Boolean', 'methodWithParams(a:Number,b:String):void', 'willFailToList' ]
    c.static_properties = [ "TEST_STATIC" ]
    c.static_methods = [ 'staticMethod():void', "", nil, "willFailToList"]

    l = CompletionsList.new(c)

    list = l.list
    #list.each_with_index { |o,i| puts "#{i} Title: '#{o['title']}' Data: '#{o['data']}' Type: '#{o['typeof']}'" }

    assert_equal('testProperty',                        list[0]['title'])
    assert_equal('-',                                   list[1]['title'])
    assert_equal('testGetter',                          list[2]['title'])
    assert_equal('-',                                   list[3]['title'])
    assert_equal('paramaterless()',                     list[4]['title'])
    assert_equal('paramaterless()',                     list[4]['data'])
    assert_equal('Boolean',                             list[4]['typeof'])
    assert_equal('methodWithParams()',                  list[5]['title'])
    assert_equal('methodWithParams(a:Number,b:String)', list[5]['data'])
    assert_equal('void',                                list[5]['typeof'])
    assert_equal('-',                                   list[6]['title'])
    assert_equal('TEST_STATIC',                         list[7]['title'])
    assert_equal('-',                                   list[8]['title'])
    assert_equal('staticMethod()',                      list[9]['title'])

  end

  def test_dialog_2

    c = MockClassParser.new
    c.properties = [ "testProperty" ]
    c.gettersetters = [ "testGetter", nil ]
    c.methods = [ 'paramaterless():Boolean', 'methodWithParams(a:Number,b:String):void', 'willFailToList', ' setBody( body:Object ):void' ]
    c.static_properties = [ "TEST_STATIC" ]
    c.static_methods = [ 'staticMethod():void', "", nil, "willFailToList" ]

    l = CompletionsList.new(c)

    list = l.list_d2
    #list.each_with_index { |o,i| puts "#{i} Display: '#{o['display']}' Data: '#{o['data']}' Type: '#{o['typeof']}' Image: '#{o['image']}'" }

    assert_equal('testProperty',                        list[0]['display'])
    assert_equal('testProperty',                        list[0]['match'])
    assert_equal('Property',                            list[0]['image'])

    assert_equal('testGetter',                          list[1]['display'])
    assert_equal('testGetter',                          list[1]['match'])
    assert_equal('Property',                            list[1]['image'])

    assert_equal('paramaterless()',                     list[2]['display'])
    assert_equal('paramaterless()',                     list[2]['data'])
    assert_equal('paramaterless',                       list[2]['match'])
    assert_equal('Boolean',                             list[2]['typeof'])
    assert_equal('Method',                              list[2]['image'])

    assert_equal('methodWithParams()',                  list[3]['display'])
    assert_equal('methodWithParams(a:Number,b:String)', list[3]['data'])
    assert_equal('methodWithParams',                    list[3]['match'])
    assert_equal('void',                                list[3]['typeof'])
    assert_equal('Method',                              list[3]['image'])

    assert_equal('setBody( body:Object )',              list[4]['data'])

    assert_equal('TEST_STATIC',                         list[5]['display'])
    assert_equal('TEST_STATIC',                         list[5]['match'])
    assert_equal('Constant',                            list[5]['image'])

    assert_equal('staticMethod()',                      list[6]['display'])
    assert_equal('staticMethod',                        list[6]['match'])
    assert_equal('Method',                              list[6]['image'])

  end

  def test_attributes_d2

    c = MockClassParser.new

    c.properties    = [ "testProperty" ]
    c.gettersetters = [ "testGetter", nil ]
    c.effects       = [ 'testEffect' ]
    c.events        = [ 'testEvent' ]
    c.styles        = [ 'testStyle' ]

    l = CompletionsList.new(c)

    list = l.attributes_d2

    assert_equal('testEffect', list[2]['display'])
    assert_equal('testEffect', list[2]['match'])
    assert_equal('Effect',     list[2]['image'])

    assert_equal('testEvent', list[3]['display'])
    assert_equal('testEvent', list[3]['match'])
    assert_equal('Event',     list[3]['image'])

    assert_equal('testStyle', list[4]['display'])
    assert_equal('testStyle', list[4]['match'])
    assert_equal('Style',     list[4]['image'])

  end

end
