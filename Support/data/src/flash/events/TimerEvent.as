package flash.events
{
	import flash.events.Event;
	import flash.events.Event;

	public class TimerEvent extends Event
	{
		public function TimerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		override function clone():Event;
		override function toString():String;
		public function updateAfterEvent():void;
		public static const TIMER:String = "timer";
		public static const TIMER_COMPLETE:String = "timerComplete";
	}
}