package flash.events
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.Event;

	public class FocusEvent extends Event
	{
		public var keyCode:uint;
		public var relatedObject:InteractiveObject;
		public var shiftKey:Boolean;
		public function FocusEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, relatedObject:InteractiveObject = null, shiftKey:Boolean = false, keyCode:uint = 0);
		override function clone():Event;
		override function toString():String;
		public static const FOCUS_IN:String = "focusIn";
		public static const FOCUS_OUT:String = "focusOut";
		public static const KEY_FOCUS_CHANGE:String = "keyFocusChange";
		public static const MOUSE_FOCUS_CHANGE:String = "mouseFocusChange";
	}
}