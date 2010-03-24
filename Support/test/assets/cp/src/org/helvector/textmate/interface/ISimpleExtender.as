package org.helvector.textmate.interface
{

import org.helvector.textmate.interface.ISimple;

public interface ISimpleExtender extends ISimple
{

	function get simpleExtenderProperty():Number;

	function simpleExtederMethod():void;

	/*

	function commentedOutSimpleExtederMethod():void;

	*/

	function mulitlineParams(one:String, /*   */

two:Number):void;

	//function anotherCommentedOutSimpleExtederMethod():void;
}

}