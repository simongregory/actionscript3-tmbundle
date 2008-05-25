package flash.events
{
	import flash.events.Event;
	import flash.events.Event;

	public class ActivityEvent extends Event
	{
		public var activating:Boolean;
		public function ActivityEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, activating:Boolean = false);
		override function clone():Event;
		override function toString():String;
		public static const ACTIVITY:String = "activity";
	}
}