//AS3///////////////////////////////////////////////////////////////////////////
//
// Copyright 2008 Simon Gregory.
//
////////////////////////////////////////////////////////////////////////////////

package org.helvector.textmate.views {

/**
 *  Abstract level dummy Class for autocompletion tests.
 *
 *  @langversion ActionScript 3
 *  @playerversion Flash 9.0.0
 *
 *  @author Simon Gregory
 *  @since  29.05.2008
 */
public class AbstractView
	   extends Object
	   implements ViewInterface {

	public function AbstractView(){
		super();
		//Add override and final.
	}

	//---------------------------------------
	// PRIVATE
	//---------------------------------------

	private var _abstractPrivateVar:Array;
	private var _abstractAccessor:String;

	private function abstractPrivateFunction():void {}
    private function get abstractPrivateAccessor():String {}
	private function set abstractPrivateAccessor(value:String):void {}

	//---------------------------------------
	// PROTECTED
	//---------------------------------------

	protected var _abstractProtectedVar:String;

	protected function abstractProtectedFunction():void {}

    protected function get abstractProtectedAccessor():String {}
	protected function set abstractProtectedAccessor(value:String):void {}

	//---------------------------------------
	// PUBLIC
	//---------------------------------------

    public var abstractPublicVar:Number;

	public function abstractPublicFunction():void {}

    public function get abstractPublicAccessor():String {}
	public function set abstractPublicAccessor(value:String):void {}

}

}

