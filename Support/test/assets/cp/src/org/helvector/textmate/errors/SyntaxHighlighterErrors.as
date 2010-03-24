//AS3///////////////////////////////////////////////////////////////////////////
//
// Copyright 2008 Simon Gregory.
//
////////////////////////////////////////////////////////////////////////////////

package org.helvector.textmate.controllers {

/**
 *  Deliberately contains errors that should be caaught by the syntax highlighter.
 */
public class ErrorHighlighter sdfs extends Object ,
 										   Cheese
								   implements AClass, BClass
{

	public function ErrorHighlighter(){
		super();
	}

	/**
	 *	Shows error when content is added to the method
	 */
	public function get testErrorGetter( sdfsdfsdf ) : Object {   }

	/**
	 *	Shows error when return value for a setter is not void.
	 */
	private function set invalidReturnSetter(value:int): int {}

	/**
	 *	Shows error when a second param is added.
	 */
	private function set testErrorSetter(value:Object,

														): void {}


}

}

