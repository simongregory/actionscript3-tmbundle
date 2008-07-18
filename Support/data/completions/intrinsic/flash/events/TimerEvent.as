package flash.events {
	public class TimerEvent extends Event {
		public function TimerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		public override function clone():Event;
		public override function toString():String;
		public function updateAfterEvent():void;
		public static const TIMER:String = "timer";
		public static const TIMER_COMPLETE:String = "timerComplete";
	}
}
