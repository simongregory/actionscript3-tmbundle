package fl.motion
{
public interface ITween
{
	function get target():String;
	function set target(value:String):void;
	function getValue(time:Number, begin:Number, change:Number, duration:Number):Number;
}
}
