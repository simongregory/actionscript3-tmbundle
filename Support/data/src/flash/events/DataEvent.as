package flash.events
{
	import flash.events.Event;
	import flash.events.TextEvent;

	public class DataEvent extends TextEvent
	{
		public var data:String;
		public function DataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:String = "");
		override function clone():Event;
		override function toString():String;
		public static const DATA:String = "data";
	}
}