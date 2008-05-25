package flash.events
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.Event;

	public class MouseEvent extends Event
	{
		public var altKey:Boolean;
		public var buttonDown:Boolean;
		public var ctrlKey:Boolean;
		public var delta:int;
		public var localX:Number;
		public var localY:Number;
		public var relatedObject:InteractiveObject;
		public var shiftKey:Boolean;
		public var stageX:Number;
		public var stageY:Number;
		public function MouseEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false, localX:Number, localY:Number, relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, delta:int = 0);
		override function clone():Event;
		override function toString():String;
		public function updateAfterEvent():void;
		public static const CLICK:String = "click";
		public static const DOUBLE_CLICK:String = "doubleClick";
		public static const MOUSE_DOWN:String = "mouseDown";
		public static const MOUSE_MOVE:String = "mouseMove";
		public static const MOUSE_OUT:String = "mouseOut";
		public static const MOUSE_OVER:String = "mouseOver";
		public static const MOUSE_UP:String = "mouseUp";
		public static const MOUSE_WHEEL:String = "mouseWheel";
		public static const ROLL_OUT:String = "rollOut";
		public static const ROLL_OVER:String = "rollOver";
	}
}