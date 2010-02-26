package flash.desktop {
	import flash.display.NativeMenu;
	public class SystemTrayIcon extends InteractiveIcon {
		public function get bitmaps():Array;
		public function set bitmaps(value:Array):void;
		public function get height():int;
		public function get menu():NativeMenu;
		public function set menu(value:NativeMenu):void;
		public function get tooltip():String;
		public function set tooltip(value:String):void;
		public function get width():int;
		public static const MAX_TIP_LENGTH:Number = 63;
	}
}
