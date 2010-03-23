#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "c_env"
require "as3/parsers/class_parser"

class TestAs3ParsersClassParser < Test::Unit::TestCase
  def bundle_support
    File.expand_path(File.dirname(__FILE__)+'../../../../../')
  end

  def setup
    ENV['TM_BUNDLE_SUPPORT'] = bundle_support
  end

  def intrinsic_base_path
    "#{bundle_support}/Data/completions/intrinsic"
  end
  
  def assert_method(cp,signature)
    assert(cp.methods.include?(signature), "Failed to find '#{signature}' method")
  end

  def assert_static_method(cp,signature)
    assert(cp.static_methods.include?(signature), "Failed to find '#{signature}' static method")
  end
  
  def assert_property(cp,signature)
    assert(cp.properties.include?(signature), "Failed to find '#{signature}' property")
  end

  def assert_static_property(cp,signature)
    assert(cp.static_properties.include?(signature), "Failed to find '#{signature}' static property")
  end

  def assert_gettersetter(cp,signature)
    assert(cp.gettersetters.include?(signature), "Failed to find '#{signature}' gettersetter")
  end
  
  def test_store_all_class_members_error_class
    f = File.new("#{intrinsic_base_path}/Error.as").read.strip
    c = ClassParser.new
    c.load(f, 'this')

    assert_method(c,'getStackTrace():String')
    assert_method(c,'toString():String')
    
    assert_property(c,'message')
    assert_property(c,'name')
    
    assert_gettersetter(c,'errorID')
  end
  
  def test_store_all_class_members_math_class
    f = File.new("#{intrinsic_base_path}/Math.as").read.strip
    c = ClassParser.new
    c.load(f,'this')
    
    assert_static_property(c,'LOG10E')
    assert_static_property(c,'SQRT1_2')

    assert_static_method(c,'abs()') #(val:Number):Number')
    assert_static_method(c,'max()') #(val1:Number, val2:Number, ... rest):Number')
    assert_static_method(c,'sqrt()') #(val:Number):Number')
  end

  def test_store_all_class_members_mouseevent_class
    f = File.new("#{intrinsic_base_path}/flash/events/MouseEvent.as").read.strip
    c = ClassParser.new
    c.load(f, 'this')
    
    # Methods in the class
    assert_method(c,'updateAfterEvent():void')
    
    # Methods in the super class
    assert_method(c,'formatToString(className:String, ... arguments):String')
    
    # Getterseets in class
    assert_gettersetter(c,'stageX') #():Number
    assert_gettersetter(c,'stageY') #():Number
    assert_gettersetter(c,'shiftKey') #(value:Boolean):void')
    
    # Gettersetters in super class
    assert_gettersetter(c,'currentTarget') #():Object')
    assert_gettersetter(c,'bubbles') #():Boolean')
    
    # Static property in class
    assert_static_property(c,'MOUSE_DOWN')

    # Static property in super class
    assert_static_property(c,'TAB_CHILDREN_CHANGE')
    
  end

  def test_store_all_class_members_stackframe_class
    f = File.new("#{intrinsic_base_path}/flash/sampler/StackFrame.as").read.strip
    c = ClassParser.new
    c.load(f, 'this')
    
    # properties in the class
    assert_property(c,'file')
    assert_property(c,'line')
    assert_property(c,'name')
    
  end
end

