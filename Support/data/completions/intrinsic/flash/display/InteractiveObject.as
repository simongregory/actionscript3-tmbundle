package flash.display {
	public class InteractiveObject extends DisplayObject {
		public function get contextMenu():NativeMenu;
		public function set contextMenu(value:NativeMenu):void;
		public function get doubleClickEnabled():Boolean;
		public function set doubleClickEnabled(value:Boolean):void;
		public function get focusRect():Object;
		public function set focusRect(value:Object):void;
		public function get mouseEnabled():Boolean;
		public function set mouseEnabled(value:Boolean):void;
		public function get tabEnabled():Boolean;
		public function set tabEnabled(value:Boolean):void;
		public function get tabIndex():int;
		public function set tabIndex(value:int):void;
		public function InteractiveObject();
	}
}
