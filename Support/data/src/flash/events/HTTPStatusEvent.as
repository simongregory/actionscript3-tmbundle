package flash.events
{
	import flash.events.Event;
	import flash.events.Event;

	public class HTTPStatusEvent extends Event
	{
		public var status:int;
		public function HTTPStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:int = 0);
		override function clone():Event;
		override function toString():String;
		public static const HTTP_STATUS:String = "httpStatus";
	}
}