package flash.events {
	import flash.geom.Rectangle;
	public class NativeWindowBoundsEvent extends Event {
		public function get afterBounds():Rectangle;
		public function get beforeBounds():Rectangle;
		public function NativeWindowBoundsEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, beforeBounds:Rectangle = null, afterBounds:Rectangle = null);
		public override function clone():Event;
		public override function toString():String;
		public static const MOVE:String = "move";
		public static const MOVING:String = "moving";
		public static const RESIZE:String = "resize";
		public static const RESIZING:String = "resizing";
	}
}
