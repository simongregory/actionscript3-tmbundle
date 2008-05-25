package flash.events
{
	import flash.events.Event;
	import flash.events.Event;

	public class StatusEvent extends Event
	{
		public var code:String;
		public var level:String;
		public function StatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, code:String = "", level:String = "");
		override function clone():Event;
		override function toString():String;
		public static const STATUS:String = "status";
	}
}