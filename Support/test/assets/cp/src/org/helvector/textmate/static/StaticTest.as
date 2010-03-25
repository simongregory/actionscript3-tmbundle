package org.helvector.textmate.static
{

import flash.events.Event;

public class StaticTest {

	public static const TEST_PUBLIC_STATIC_CONST:String;
	public static var TEST_PUBLIC_STATIC_VAR:Number;

	static public const TEST_STATIC_PUBLIC_CONST:String;
	static public var TEST_STATIC_PUBLIC_VAR:Number;

	public static function testPublicStaticFunction(param:*):void {}
	static public function testStaticPublicFunction():Event{}

	public static function testStaticMultilineMethod(one:Number,
		two:String,
		three:int): 		Object{}

	static public function testAltStaticMultilineMethod(one:Number=3,
	two:String="hello",
	//
three:int
	/*    */):* {}

	public static function get testPublicStaticAccessor():Object{}
	public static function set testPublicStaticAccessor(value:Boolean):void{}

	static public function get testStaticPublicAccessor():Object{}
	static public function set testStaticPublicAccessor():void{}

	//No case for protected const.

	private static const TEST_PRIVATE_STATIC_CONST:String;
	private static var   TEST_PRIVATE_STATIC_VAR:String;

	static private const TEST_STATIC_PRIVATE_CONST:String;
	static private var   TEST_STATIC_PRIVATE_VAR:String;

	private static function testPrivateStaticFunction():void{}

	private static function get testPrivateStaticAccessor():Object{}
	private static function set testPrivateStaticAccessor():void{}

	public function StaticTest()
	{
		super();
	}

}

}