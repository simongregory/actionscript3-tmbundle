package org.helvector.textmate.interface
{
import org.helvector.textmate.interface.IAltOne;
import org.helvector.textmate.interface.IAltTwo;
public interface IMultipleTwo extends IAltOne, IAltTwo
{
    function testMultipleTwoMethod():void;
	function get testMultipleTwoProperty():Object;
}
}