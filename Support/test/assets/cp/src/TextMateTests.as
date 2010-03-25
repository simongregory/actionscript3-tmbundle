//AS3///////////////////////////////////////////////////////////////////////////
//
// Copyright 2008 Simon Gregory.
//
////////////////////////////////////////////////////////////////////////////////

package
{

import flash.events.Event;
import flash.display.Sprite;

import org.helvector.textmate.interface.ISimpleExtender;
import org.helvector.textmate.static.StaticTest;

/**
 *  @langversion ActionScript 3
 *  @playerversion Flash 9.0.0
 *
 *  @since  02.08.2008
 */
public class TextMateTests extends Sprite
{

	/**
	 * @private
	 */
	private static const CHEESE_EVENT:String = "cheeseEvent";

	public var stilton:int;
	public const cheddar:String = "CHEDDAR";
	protected var _wensleydayle:Sprite;
	private var _edam:Event;

	/**
	 *	@constructor
	 */
	public function TextMateTests()
	{
		super();
		stage.addEventListener( Event.ENTER_FRAME, initialize );

	}

	/**
	 *	@private
	 */
	private function initialize( event:Event , dummy:Boolean=false ):void
	{
		stage.removeEventListener( Event.ENTER_FRAME, initialize );

		trace( "TextMateTests::initialize()" );

		var b:ISimpleExtender = new Object();

        //Manual completion tests
		b.
		b.simp
		b.simpleEx
		Event.
		Event.RE
        event.
		stage.addE
		stage.contextMenu



	}

	/**
	 *	@private
	 */
	public function multilineMethodParams( one:Number,
														/* */
										   two:String ):void
	{

		if (true)
		if (1<9)
		if ( )

		do
		{

		} while

		for each (var item:Object in obj)
		{

		}

	}

	/**
	 *	@private
	 */
	public function overloadedMultilineMethodParams ( zero:Number,
													 one:Number = 10,
													 four:String = "chalk",
													 two:String =
														'cheese',  /* */
													 six:String=CHEESE_EVENT,
													 three:Boolean=true,
													 seven:int=null ):void {}

/* */
													/* */
	/**
	 * @private
	 */
	public function testLoops():void
	{
		for ( var i:int=0; i<=n; i++ ){}
		for ( var i:int=0; i <= n; i++ ){}
		for ( var i:int = 0; i <= n.length; i++){}
		for (var i:int = 0; i<=n.length; i++){}
		for (var p:String in obj){}
		for each (var item:Object in obj){}
	}

	public function multilineMethodParamsReturning( one:Number,
 two:String ):Event
	{

}	/**
	 * @private
	 */
	public function overloadedMultilineMethodParamsReturning( zero:Number,
													 one:Number = 10,
													 four:String = "chalk",
													 two:String =
														'cheese',  /* */
													 six:String=CHEESE_EVENT,
													 three:Boolean=true,
													 seven:int=null ):Sprite {}


}

}