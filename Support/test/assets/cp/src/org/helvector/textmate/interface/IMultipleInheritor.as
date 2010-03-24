//AS3///////////////////////////////////////////////////////////////////////////
//
// Test Banner.
//
////////////////////////////////////////////////////////////////////////////////

package org.helvector.textmate.interface
{
import org.helvector.textmate.interface.IMultipleOne;
import org.helvector.textmate.interface.IMultipleThree;
import org.helvector.textmate.interface.IMultipleTwo;
/**
 *  TextMate language defintion and auto completion test classes for interfaces.
 *
 *  @langversion ActionScript 3
 *  @playerversion Flash 9.0.0
 *
 *  @author Simon Gregory
 *  @since  29.05.2008
 */
public interface IMultipleInheritor extends IMultipleOne,
									   		IMultipleTwo,
									   		IMultipleThree {


	function testMethodA():IMultipleOne;

	function testMethodB():void;

	function testMethodC( /* multi-line comment */
						  one : Number,
						  // single line comment
						  two:String ) : IMultipleThree;

    function testMethodD():void;

	function get testPropertyA() : Object;

	function get testPropertyB():int;
	function set testPropertyB(value:int):void;

}

}