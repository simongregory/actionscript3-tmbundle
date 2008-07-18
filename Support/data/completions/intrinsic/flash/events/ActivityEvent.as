package flash.events {
	public class ActivityEvent extends Event {
		public function get activating():Boolean;
		public function set activating(value:Boolean):void;
		public function ActivityEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, activating:Boolean = false);
		public override function clone():Event;
		public override function toString():String;
		public static const ACTIVITY:String = "activity";
	}
}
