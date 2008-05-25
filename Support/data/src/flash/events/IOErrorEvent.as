package flash.events
{
	import flash.events.Event;
	import flash.events.ErrorEvent;

	public class IOErrorEvent extends ErrorEvent
	{
		public function IOErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "");
		override function clone():Event;
		override function toString():String;
		public static const IO_ERROR:String = "ioError";
	}
}