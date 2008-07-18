package flash.events {
	public class FullScreenEvent extends ActivityEvent {
		public function get fullScreen():Boolean;
		public function FullScreenEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, fullScreen:Boolean = false);
		public override function clone():Event;
		public override function toString():String;
		public static const FULL_SCREEN:String = "fullScreen";
	}
}
