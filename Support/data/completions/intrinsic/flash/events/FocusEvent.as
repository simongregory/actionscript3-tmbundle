package flash.events {
	import flash.display.InteractiveObject;
	public class FocusEvent extends Event {
		public function get keyCode():uint;
		public function set keyCode(value:uint):void;
		public function get relatedObject():InteractiveObject;
		public function set relatedObject(value:InteractiveObject):void;
		public function get shiftKey():Boolean;
		public function set shiftKey(value:Boolean):void;
		public function FocusEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, relatedObject:InteractiveObject = null, shiftKey:Boolean = false, keyCode:uint = 0, direction:String = "none");
		public override function clone():Event;
		public override function toString():String;
		public static const FOCUS_IN:String = "focusIn";
		public static const FOCUS_OUT:String = "focusOut";
		public static const KEY_FOCUS_CHANGE:String = "keyFocusChange";
		public static const MOUSE_FOCUS_CHANGE:String = "mouseFocusChange";
	}
}
