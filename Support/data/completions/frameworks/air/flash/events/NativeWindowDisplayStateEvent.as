package flash.events {
	public class NativeWindowDisplayStateEvent extends Event {
		public function get afterDisplayState():String;
		public function get beforeDisplayState():String;
		public function NativeWindowDisplayStateEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, beforeDisplayState:String = "", afterDisplayState:String = "");
		public override function clone():Event;
		public override function toString():String;
		public static const DISPLAY_STATE_CHANGE:String = "displayStateChange";
		public static const DISPLAY_STATE_CHANGING:String = "displayStateChanging";
	}
}
