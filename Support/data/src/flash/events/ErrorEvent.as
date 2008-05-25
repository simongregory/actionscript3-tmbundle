package flash.events
{
	import flash.events.Event;
	import flash.events.TextEvent;

	public class ErrorEvent extends TextEvent
	{
		public function ErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "");
		override function clone():Event;
		override function toString():String;
		public static const ERROR:String = "error";
	}
}