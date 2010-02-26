package mx.core {
	import flash.display.NativeWindow;
	public interface IWindow {
		public function get maximizable():Boolean;
		public function get minimizable():Boolean;
		public function get nativeWindow():NativeWindow;
		public function get resizable():Boolean;
		public function get status():String;
		public function set status(value:String):void;
		public function get systemChrome():String;
		public function get title():String;
		public function set title(value:String):void;
		public function get titleIcon():Class;
		public function set titleIcon(value:Class):void;
		public function get transparent():Boolean;
		public function get type():String;
		public function get visible():Boolean;
		public function close():void;
		public function maximize():void;
		public function minimize():void;
		public function restore():void;
	}
}
