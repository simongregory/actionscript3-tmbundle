package flash.display {
	import flash.events.EventDispatcher;
	public class NativeMenu extends EventDispatcher {
		public function get items():Array;
		public function get numItems():int;
		public function get parent():NativeMenu;
		public function addItem(item:NativeMenuItem):NativeMenuItem;
		public function addItemAt(item:NativeMenuItem, index:int):NativeMenuItem;
		public function addSubmenu(submenu:NativeMenu, label:String):NativeMenuItem;
		public function addSubmenuAt(submenu:NativeMenu, index:int, label:String):NativeMenuItem;
		public function clone():NativeMenu;
		public function containsItem(item:NativeMenuItem):Boolean;
		public function display(stage:Stage, stageX:Number, stageY:Number):void;
		public function getItemAt(index:int):NativeMenuItem;
		public function getItemByName(name:String):NativeMenuItem;
		public function getItemIndex(item:NativeMenuItem):int;
		public function removeItem(item:NativeMenuItem):NativeMenuItem;
		public function removeItemAt(index:int):NativeMenuItem;
		public function setItemIndex(item:NativeMenuItem, index:int):void;
	}
}
