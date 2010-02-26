package flash.events {
	import flash.display.InteractiveObject;
	import flash.desktop.Clipboard;
	import flash.desktop.NativeDragOptions;
	public class NativeDragEvent extends MouseEvent {
		public var allowedActions:NativeDragOptions;
		public var clipboard:Clipboard;
		public var dropAction:String;
		public function NativeDragEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, localX:Number = NaN, localY:Number = NaN, relatedObject:InteractiveObject = null, clipboard:Clipboard = null, allowedActions:NativeDragOptions = null, dropAction:String = null, controlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, commandKey:Boolean = false);
		public override function clone():Event;
		public override function toString():String;
		public static const NATIVE_DRAG_COMPLETE:String = "nativeDragComplete";
		public static const NATIVE_DRAG_DROP:String = "nativeDragDrop";
		public static const NATIVE_DRAG_ENTER:String = "nativeDragEnter";
		public static const NATIVE_DRAG_EXIT:String = "nativeDragExit";
		public static const NATIVE_DRAG_OVER:String = "nativeDragOver";
		public static const NATIVE_DRAG_START:String = "nativeDragStart";
		public static const NATIVE_DRAG_UPDATE:String = "nativeDragUpdate";
	}
}
