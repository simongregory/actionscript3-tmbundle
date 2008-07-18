package flash.events {
	public class KeyboardEvent extends Event {
		public function get altKey():Boolean;
		public function set altKey(value:Boolean):void;
		public function get charCode():uint;
		public function set charCode(value:uint):void;
		public function get ctrlKey():Boolean;
		public function set ctrlKey(value:Boolean):void;
		public function get keyCode():uint;
		public function set keyCode(value:uint):void;
		public function get keyLocation():uint;
		public function set keyLocation(value:uint):void;
		public function get shiftKey():Boolean;
		public function set shiftKey(value:Boolean):void;
		public function KeyboardEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, charCodeValue:uint = 0, keyCodeValue:uint = 0, keyLocationValue:uint = 0, ctrlKeyValue:Boolean = false, altKeyValue:Boolean = false, shiftKeyValue:Boolean = false, controlKeyValue:Boolean = false, commandKeyValue:Boolean = false);
		public override function clone():Event;
		public override function toString():String;
		public function updateAfterEvent():void;
		public static const KEY_DOWN:String = "keyDown";
		public static const KEY_UP:String = "keyUp";
	}
}
