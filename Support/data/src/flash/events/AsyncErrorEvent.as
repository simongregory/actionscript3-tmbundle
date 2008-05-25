package flash.events
{
	import flash.events.Event;
	import flash.events.ErrorEvent;

	public class AsyncErrorEvent extends ErrorEvent
	{
		public var error:Error;
		public function AsyncErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", error:Error = null);
		override function clone():Event;
		override function toString():String;
		public static const ASYNC_ERROR:String = "asyncError";
	}
}