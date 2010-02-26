package flash.events {
	public class ScreenMouseEvent extends MouseEvent {
		public function get screenX():Number;
		public function get screenY():Number;
		public function ScreenMouseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, screenX:Number = NaN, screenY:Number = NaN, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, commandKey:Boolean = false, controlKey:Boolean = false);
		public override function clone():Event;
		public override function toString():String;
	}
}
