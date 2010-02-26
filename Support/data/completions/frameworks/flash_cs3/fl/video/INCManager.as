package fl.video
{
import flash.net.NetConnection;
public interface INCManager
{
	function get videoPlayer():VideoPlayer;
	function set videoPlayer(v:VideoPlayer):void;
	function get timeout():uint;
	function set timeout(t:uint):void;
	function get netConnection():NetConnection;
	function get bitrate():Number;
	function set bitrate(b:Number):void;
	function get streamName():String;
	function get isRTMP():Boolean;
	function get streamLength():Number;
	function get streamWidth():int;
	function get streamHeight():int;
	function connectToURL(url:String):Boolean;
	function connectAgain():Boolean;
	function reconnect():void;
	function helperDone(helper:Object, success:Boolean):void;
	function close():void;
	function getProperty(propertyName:String):*;
	function setProperty(propertyName:String, value:*):void;
}
}
