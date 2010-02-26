package flash.desktop {
	import flash.display.NativeMenu;
	public class DockIcon extends InteractiveIcon {
		public function get bitmaps():Array;
		public function set bitmaps(value:Array):void;
		public function get height():int;
		public function get menu():NativeMenu;
		public function set menu(value:NativeMenu):void;
		public function get width():int;
		public function bounce(priority:String = "informational"):void;
	}
}
