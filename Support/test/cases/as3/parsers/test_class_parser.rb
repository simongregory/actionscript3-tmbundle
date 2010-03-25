#!/usr/bin/env ruby -wKU
# encoding: utf-8

require "test/unit"
require "c_env"
require "as3/parsers/class_parser"

# Helper methods for testing
#
module ClassParserHelpers
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

  def load_doc(class_path)
    File.new("#{intrinsic_base_path}/#{class_path}").read.strip
  end

  def get_parser_for(class_path,chain='this')
    f = load_doc(class_path)
    c = ClassParser.new
    c.load(f,chain)
    c
  end

  def get_interface_parser_for(class_path)
    f = load_doc(class_path)
    c = ClassParserInterfaceTester.new
    c.load_interface(f)
    c
  end
end

# Subclass of ClassParser that exposes internal functionality for testing.
#
class ClassParserInterfaceTester < ClassParser
  def load_interface(doc)
    reset
    doc = strip_comments(doc)
    add_interface(doc) if is_interface(doc)
  end
end

class TestClassMemberParsing < Test::Unit::TestCase

  include ClassParserHelpers

  def test_store_members_error_class
    c = get_parser_for('Error.as')

    assert_method(c,'getStackTrace():String')
    assert_method(c,'toString():String')

    assert_property(c,'message')
    assert_property(c,'name')

    assert_gettersetter(c,'errorID')

    assert(c.styles.nil?, "Styles should be nil.")
    assert(c.events.nil?, "Events should be nil.")
    assert(c.effects.nil?, "Effects should be nil.")
  end

  def test_store_members_math_class
    c = get_parser_for('Math.as')

    assert_static_property(c,'LOG10E')
    assert_static_property(c,'SQRT1_2')

    assert_static_method(c,'abs(val:Number):Number')
    assert_static_method(c,'max(val1:Number, val2:Number, ... rest):Number')
    assert_static_method(c,'sqrt(val:Number):Number')

    assert(c.styles.nil?, "Styles should be nil.")
    assert(c.events.nil?, "Events should be nil.")
    assert(c.effects.nil?, "Effects should be nil.")
  end

  def test_store_members_mouseevent_class
    c = get_parser_for("flash/events/MouseEvent.as")

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
    assert_static_property(c,'CLICK')
    assert_static_property(c,'DOUBLE_CLICK')
    assert_static_property(c,'MOUSE_DOWN')
    assert_static_property(c,'MOUSE_MOVE')
    assert_static_property(c,'MOUSE_OUT')
    assert_static_property(c,'MOUSE_OVER')
    assert_static_property(c,'MOUSE_UP')
    assert_static_property(c,'MOUSE_WHEEL')
    assert_static_property(c,'ROLL_OUT')
    assert_static_property(c,'ROLL_OVER')

    # Static property in super class
    assert_static_property(c,'TAB_CHILDREN_CHANGE')
    assert_static_property(c,'RENDER')
    assert_static_property(c,'RESIZE')
    assert_static_property(c,'SCROLL')
    assert_static_property(c,'SELECT')

    assert(c.styles.nil?, "Styles should be nil.")
    assert(c.events.nil?, "Events should be nil.")
    assert(c.effects.nil?, "Effects should be nil.")
  end

  def test_store_members_stackframe_class
    c = get_parser_for("flash/sampler/StackFrame.as")

    # properties in the class
    assert_property(c,'file')
    assert_property(c,'line')
    assert_property(c,'name')

    assert(c.styles.nil?, "Styles should be nil.")
    assert(c.events.nil?, "Events should be nil.")
    assert(c.effects.nil?, "Effects should be nil.")
  end
end

class TestInterfaceMemberParsing < Test::Unit::TestCase
  include ClassParserHelpers

  def test_store_members_for_iexternalizable
    c = get_interface_parser_for('flash/utils/IExternalizable.as')

    # methods in the interface
    assert_method(c,'writeExternal(output:IDataOutput):void')
    assert_method(c,'readExternal(input:IDataInput):void')

    assert(c.styles.nil?, "Styles should be nil.")
    assert(c.events.nil?, "Events should be nil.")
    assert(c.effects.nil?, "Effects should be nil.")
  end

  def test_store_members_for_ieventdispatcher
    c = get_interface_parser_for('flash/events/IEventDispatcher.as')

    # methods in the interface
    assert_method(c,'removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void')
    assert_method(c,'hasEventListener(type:String):Boolean')
    assert_method(c,'dispatchEvent(event:Event):Boolean')
    assert_method(c,'addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void')

    assert(c.styles.nil?, "Styles should be nil.")
    assert(c.events.nil?, "Events should be nil.")
    assert(c.effects.nil?, "Effects should be nil.")
  end

  def test_store_members_for_ibitmapdrawable
    c = get_interface_parser_for('flash/display/IBitmapDrawable.as')

    assert(c.methods.nil?, "Methods should be nil.")
    assert(c.properties.nil?, "Properties should be nil.")
    assert(c.gettersetters.nil?, "GetterSetters should be nil.")
    assert(c.styles.nil?, "Styles should be nil.")
    assert(c.events.nil?, "Events should be nil.")
    assert(c.effects.nil?, "Effects should be nil.")
  end

  def test_idatainput
    c = get_interface_parser_for('flash/utils/IDataInput.as')

    assert_equal(14,c.methods.length)
    assert_equal(3, c.gettersetters.length)

    assert(c.properties.nil?, "Properties should be nil.")
    assert(c.styles.nil?, "Styles should be nil.")
    assert(c.events.nil?, "Events should be nil.")
    assert(c.effects.nil?, "Effects should be nil.")
  end
end

class TestClassTypeDetection < Test::Unit::TestCase

  include ClassParserHelpers

  def test_find_type_in_event
    d = load_doc('flash/events/Event.as')
    c = ClassParser.new

    assert_equal(nil, c.find_type(d,'foo'))
    assert_equal('Object', c.find_type(d,'currentTarget'))
    assert_equal(nil, c.find_type(d,'stopImmediatePropagation'))
    assert_equal(true, c.return_type_void)
    assert_equal('Boolean', c.find_type(d,'isDefaultPrevented'))
    assert_equal('String', c.find_type(d,'formatToString'))
  end

  def test_find_type_mouse_event
    d = load_doc('flash/events/MouseEvent.as')
    c = ClassParser.new

    # MouseEvent constants
    assert_equal('String', c.find_type(d,'CLICK'))
    assert_equal('String', c.find_type(d,'DOUBLE_CLICK'))
    assert_equal('String', c.find_type(d,'MOUSE_DOWN'))
    assert_equal('String', c.find_type(d,'MOUSE_MOVE'))
    assert_equal('String', c.find_type(d,'MOUSE_OUT'))
    assert_equal('String', c.find_type(d,'MOUSE_OVER'))
    assert_equal('String', c.find_type(d,'MOUSE_UP'))
    assert_equal('String', c.find_type(d,'MOUSE_WHEEL'))
    assert_equal('String', c.find_type(d,'ROLL_OUT'))
    assert_equal('String', c.find_type(d,'ROLL_OVER'))

    # Found in the superclass - Event
    found = c.find_type(d,'RENDER')
    assert_equal('String', found)

    assert_equal('String', c.find_type(d,'RESIZE'))
    assert_equal('String', c.find_type(d,'SCROLL'))
    assert_equal('String', c.find_type(d,'SELECT'))

  end

  def test_find_type_in_matrix
    d = load_doc('flash/geom/Matrix.as')
    c = ClassParser.new

    assert_equal(nil, c.find_type(d,'z'))
    assert_equal(false, c.return_type_void)
    assert_equal('Number', c.find_type(d,'a'))
    assert_equal(false, c.return_type_void)
    assert_equal('Number', c.find_type(d,'b'))
    assert_equal(false, c.return_type_void)
    assert_equal('Number', c.find_type(d,'c'))
    assert_equal(false, c.return_type_void)
    assert_equal('Number', c.find_type(d,'d'))
    assert_equal(false, c.return_type_void)
    assert_equal('Number', c.find_type(d,'tx'))
    assert_equal(false, c.return_type_void)
    assert_equal('Number', c.find_type(d,'ty'))
    assert_equal(false, c.return_type_void)
    assert_equal('Matrix', c.find_type(d,'clone'))
    assert_equal(false, c.return_type_void)
    assert_equal('Point', c.find_type(d,'deltaTransformPoint'))
    assert_equal(false, c.return_type_void)
    assert_equal(nil, c.find_type(d,'translate'))
    assert_equal(true, c.return_type_void)
    assert_equal(nil, c.find_type(d,'createGradientBox'))
    assert_equal(true, c.return_type_void)
  end

  def test_find_type_in_data
    d = load_doc('Date.as')
    c = ClassParser.new

    assert_equal(nil, c.find_type(d,'foo'))
    assert_equal('Number', c.find_type(d,'dateUTC'))
    assert_equal('Number', c.find_type(d,'millisecondsUTC'))
    assert_equal('Number', c.find_type(d,'getUTCMilliseconds'))
    assert_equal('String', c.find_type(d,'toTimeString'))
    assert_equal('Number', c.find_type(d,'UTC'))
  end

  def test_find_type_in_ieventdispatcher
    d = load_doc('flash/events/IEventDispatcher.as')
    c = ClassParser.new

    assert_equal(nil, c.find_type(d,'foo'))
    assert_equal('Boolean', c.find_type(d,'hasEventListener'))
    assert_equal(false, c.return_type_void)
    assert_equal('Boolean', c.find_type(d,'dispatchEvent'))
    assert_equal(false, c.return_type_void)
    assert_equal('Boolean', c.find_type(d,'willTrigger'))
    assert_equal(false, c.return_type_void)
    assert_equal(nil, c.find_type(d,'removeEventListener'))
    assert_equal(true, c.return_type_void)
    assert_equal(nil, c.find_type(d,'addEventListener'))
    assert_equal(true, c.return_type_void)
  end

  def test_find_type_in_idatainput
    d = load_doc('flash/utils/IDataInput.as')
    c = ClassParser.new

    assert_equal(nil, c.find_type(d,'foo'))

    assert_equal('uint', c.find_type(d,'objectEncoding'))
    assert_equal(false, c.return_type_void)

    assert_equal('String', c.find_type(d,'endian'))
    assert_equal(false, c.return_type_void)

    assert_equal('uint', c.find_type(d,'bytesAvailable'))
    assert_equal(false, c.return_type_void)

    assert_equal('Boolean', c.find_type(d,'readBoolean'))
    assert_equal(false, c.return_type_void)

    assert_equal('int', c.find_type(d,'readByte'))
    assert_equal(false, c.return_type_void)

    assert_equal(nil, c.find_type(d,'readBytes'))
    assert_equal(true, c.return_type_void)

    assert_equal('Number', c.find_type(d,'readDouble'))
    assert_equal(false, c.return_type_void)

    assert_equal('Number', c.find_type(d,'readFloat'))
    assert_equal(false, c.return_type_void)

    assert_equal('int', c.find_type(d,'readInt'))
    assert_equal(false, c.return_type_void)

    assert_equal('String', c.find_type(d,'readMultiByte'))
    assert_equal(false, c.return_type_void)

    assert_equal('*', c.find_type(d,'readObject'))
    assert_equal(false, c.return_type_void)

    assert_equal('int', c.find_type(d,'readShort'))
    assert_equal(false, c.return_type_void)

    assert_equal('uint', c.find_type(d,'readUnsignedByte'))
    assert_equal(false, c.return_type_void)

    assert_equal('uint', c.find_type(d,'readUnsignedInt'))
    assert_equal(false, c.return_type_void)

    assert_equal('uint', c.find_type(d,'readUnsignedShort'))
    assert_equal(false, c.return_type_void)

    assert_equal('String', c.find_type(d,'readUTF'))
    assert_equal(false, c.return_type_void)

    assert_equal('String', c.find_type(d,'readUTFBytes'))
    assert_equal(false, c.return_type_void)
  end

end

module HelvectorClassParserHelpers

  include ClassParserHelpers

  def helvector_test_base_path
    "#{bundle_support}/test/assets/cp/src"
  end

  def load_doc(class_path)
    File.new("#{helvector_test_base_path}/#{class_path}").read.strip
  end

  def get_parser_for(class_path,chain='this')
    f = load_doc(class_path)
    c = ClassParser.new
    c.load(f, chain)
    c
  end

  def get_interface_parser_for(class_path)
    f = load_doc(class_path)
    c = ClassParserInterfaceTester.new
    c.load_interface(f)
    c
  end

end

class TestHelvectorClassMemberParsing < Test::Unit::TestCase

  include HelvectorClassParserHelpers

  def test_store_members_for_textmatetests
    c = get_parser_for('TextMateTests.as')

    #We have private access to these class methods.
    assert_method(c,'initialize( event:Event , dummy:Boolean=false ):void')
    assert_method(c,'multilineMethodParams(one:Number,two:String):void')
    assert_method(c,'multilineMethodParamsReturning(one:Number,two:String):Event')
    assert_method(c,"overloadedMultilineMethodParams(zero:Number,one:Number=10,four:String=\"chalk\",two:String='cheese',six:String=CHEESE_EVENT,three:Boolean=true,seven:int=null):void")
    assert_method(c,"overloadedMultilineMethodParamsReturning(zero:Number,one:Number=10,four:String=\"chalk\",two:String='cheese',six:String=CHEESE_EVENT,three:Boolean=true,seven:int=null):Sprite")

    # Private access to properties
    assert_property(c,'_wensleydayle')
    assert_property(c,'cheddar')
    assert_property(c,'stilton')
    assert_property(c,'_edam')

    #Public and protected access to superclasses.
    assert_method(c,'areInaccessibleObjectsUnderPoint(point:Point):Boolean')
    assert_method(c,'getRect(targetCoordinateSpace:DisplayObject):Rectangle')
    assert_method(c,'startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void')
    assert_method(c,'setChildIndex(child:DisplayObject, index:int):void')

    #No styles, events or effects are defined.
    assert(c.styles.nil?, "Styles should be nil.")
    assert(c.events.nil?, "Events should be nil.")
    assert(c.effects.nil?, "Effects should be nil.")
  end

  def test_store_interface_members_for_isimple_extender
    c = get_interface_parser_for('org/helvector/textmate/interface/ISimpleExtender.as')

    # methods in the interface
    assert_method(c,'simpleExtederMethod():void')
    assert_method(c,'mulitlineParams(one:String,two:Number):void')

    # properties in the superclass
    assert_gettersetter(c,'simpleExtenderProperty')

    # methods in the superclass
    assert_method(c,'simpleMethod():void')

    # properties in the superclass
    assert_gettersetter(c,'simpleProperty')

  end

  def test_store_interface_members_for_imultipleinheritor
    c = get_interface_parser_for('org/helvector/textmate/interface/IMultipleInheritor.as')

    # methods in the interface
    assert_method(c,'testMethodA():IMultipleOne')
    assert_method(c,'testMethodB():void')
    assert_method(c,'testMethodC(one:Number,two:String):IMultipleThree')
    assert_method(c,'testMethodD():void')

    # properties in the class
    assert_gettersetter(c,'testPropertyA')
    assert_gettersetter(c,'testPropertyB')

    # methods in the superclass IMultipleOne
    assert_method(c,'testMultipleOneMethod():Sprite')
    assert_gettersetter(c,'testMultipleOneProperty')

    # methods in the superclass IMultipleTwo
    assert_method(c,'testMultipleTwoMethod():void')
    assert_gettersetter(c,'testMultipleTwoProperty')

    # methods in the superclass IMultipleThree
    assert_method(c,'testMultipleThreeMethod():Object')
    assert_gettersetter(c,'testMultipleThreeProperty')

    # methods in the superclass AltTwo, IMultipleTwo
    assert_method(c,'testAltTwoMethod():void')
    assert_gettersetter(c,'testAltTwoProperty')

    # methods in the superclass AltOne, IMultipleTwo
    assert_method(c,'testAltOneMethod():void')
    assert_gettersetter(c,'testAltOneProperty')

  end

end

class TestHelvectorClassTypeDetection < Test::Unit::TestCase

  include HelvectorClassParserHelpers

  def test_overloaded_multiline_method_params_return
    d = load_doc('TextMateTests.as')
    c = ClassParser.new

    assert_equal(nil, c.find_type(d,'foo'))
    assert_equal('Sprite', c.find_type(d,'overloadedMultilineMethodParamsReturning'))
    assert_equal(nil, c.find_type(d,'overloadedMultilineMethodParams'))
  end

  def test_multiline_method_params_return
    d = load_doc('TextMateTests.as')
    c = ClassParser.new

    assert_equal(nil, c.find_type(d,'foo'))
    assert_equal('Event', c.find_type(d,'multilineMethodParamsReturning'))
    assert_equal(nil, c.find_type(d,'multilineMethodParams'))
  end

  def test_store_interface_members_for_imultipleinheritor_type

    d = load_doc('org/helvector/textmate/interface/IMultipleInheritor.as')
    c = ClassParser.new

    assert_equal(nil, c.find_type(d,'foo'))

    # methods in the interface
    assert_equal('IMultipleOne', c.find_type(d,'testMethodA'))
    assert_equal(nil, c.find_type(d,'testMethodB'))
    assert_equal('IMultipleThree', c.find_type(d,'testMethodC'))
    assert_equal(nil, c.find_type(d,'testMethodD'))

    # properties in the class
    assert_equal('Object', c.find_type(d,'testPropertyA'))
    assert_equal('int', c.find_type(d,'testPropertyB'))

    # methods in the superclass IMultipleOne
    assert_equal('Sprite', c.find_type(d,'testMultipleOneMethod'))
    assert_equal('Object', c.find_type(d,'testMultipleOneProperty'))

    # methods in the superclass IMultipleTwo
    assert_equal(nil, c.find_type(d,'testMultipleTwoMethod'))
    assert_equal('Object', c.find_type(d,'testMultipleTwoProperty'))

    # methods in the superclass IMultipleThree
    assert_equal('Object', c.find_type(d,'testMultipleThreeMethod'))
    assert_equal('Math', c.find_type(d,'testMultipleThreeProperty'))

    # methods in the superclass AltTwo, IMultipleTwo
    assert_equal(nil, c.find_type(d,'testAltTwoMethod'))
    assert_equal('Object', c.find_type(d,'testAltTwoProperty'))

    # methods in the superclass AltOne, IMultipleTwo
    assert_equal(nil, c.find_type(d,'testAltOneMethod'))
    assert_equal('Object', c.find_type(d,'testAltOneProperty'))

  end

end

class TestHelvectorStaticClass < Test::Unit::TestCase

  include HelvectorClassParserHelpers

  def test_store_members_for_statictests
    c = get_parser_for('org/helvector/textmate/static/StaticTest.as')

    assert_static_property(c,'TEST_PRIVATE_STATIC_CONST')
    assert_static_property(c,'TEST_PRIVATE_STATIC_VAR')
    assert_static_property(c,'TEST_STATIC_PRIVATE_CONST')
    assert_static_property(c,'TEST_STATIC_PRIVATE_VAR')
    assert_static_property(c,'TEST_STATIC_PUBLIC_VAR')
    assert_static_property(c,'TEST_STATIC_PUBLIC_CONST')
    assert_static_property(c,'TEST_PUBLIC_STATIC_CONST')
    assert_static_property(c,'TEST_PUBLIC_STATIC_VAR')

    assert_static_method(c,'testPublicStaticFunction(param:*):void')
    assert_static_method(c,'testStaticPublicFunction():Event')
    assert_static_method(c,'testPrivateStaticFunction():void')
    assert_static_method(c,'testStaticMultilineMethod(one:Number,two:String,three:int):Object')
    assert_static_method(c,'testAltStaticMultilineMethod(one:Number=3,two:String="hello",three:int):*')

    assert_static_property(c,'testPublicStaticAccessor')
    assert_static_property(c,'testStaticPublicAccessor')
    assert_static_property(c,'testPrivateStaticAccessor')

  end

  def test_static_return_types
    d = load_doc('org/helvector/textmate/static/StaticTest.as')
    c = ClassParser.new

    assert_equal(nil, c.find_type(d,'foo'))

    # methods in the interface
    assert_equal('Event', c.find_type(d,'testStaticPublicFunction'))
    assert_equal('Object', c.find_type(d,'testStaticMultilineMethod'))
    assert_equal('Object', c.find_type(d,'testPublicStaticAccessor'))
    assert_equal('String', c.find_type(d,'TEST_PRIVATE_STATIC_CONST'))
    assert_equal('Number', c.find_type(d,'TEST_PUBLIC_STATIC_VAR'))
    assert_equal('String', c.find_type(d,'TEST_PUBLIC_STATIC_CONST'))

  end
end
