package flash.events
{
	import flash.events.Event;
	import flash.events.Event;

	public class ProgressEvent extends Event
	{
		public var bytesLoaded:uint;
		public var bytesTotal:uint;
		public function ProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:uint = 0, bytesTotal:uint = 0);
		override function clone():Event;
		override function toString():String;
		public static const PROGRESS:String = "progress";
		public static const SOCKET_DATA:String = "socketData";
	}
}