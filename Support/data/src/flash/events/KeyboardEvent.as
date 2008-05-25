package flash.events
{
	import flash.events.Event;
	import flash.events.Event;

	public class KeyboardEvent extends Event
	{
		public var altKey:Boolean;
		public var charCode:uint;
		public var ctrlKey:Boolean;
		public var keyCode:uint;
		public var keyLocation:uint;
		public var shiftKey:Boolean;
		public function KeyboardEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, charCode:uint = 0, keyCode:uint = 0, keyLocation:uint = 0, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false);
		override function clone():Event;
		override function toString():String;
		public function updateAfterEvent():void;
		public static const KEY_DOWN:String = "keyDown";
		public static const KEY_UP:String = "keyUp";
	}
}