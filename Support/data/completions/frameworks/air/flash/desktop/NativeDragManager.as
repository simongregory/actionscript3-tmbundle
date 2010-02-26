package flash.desktop {
	import flash.display.InteractiveObject;
	import flash.display.BitmapData;
	import flash.geom.Point;
	public class NativeDragManager {
		public static function get dragInitiator():InteractiveObject;
		public static function get dropAction():String;
		public function set dropAction(value:String):void;
		public static function get isDragging():Boolean;
		public static function acceptDragDrop(target:InteractiveObject):void;
		public static function doDrag(dragInitiator:InteractiveObject, clipboard:Clipboard, dragImage:BitmapData = null, offset:Point = null, allowedActions:NativeDragOptions = null):void;
	}
}
