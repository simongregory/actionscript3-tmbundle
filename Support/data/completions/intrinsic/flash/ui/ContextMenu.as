package flash.ui {
	import flash.events.EventDispatcher;
	import flash.display.Stage;
	public final  class ContextMenu extends EventDispatcher {
		public function get builtInItems():ContextMenuBuiltInItems;
		public function set builtInItems(value:ContextMenuBuiltInItems):void;
		public function get customItems():Array;
		public function set customItems(value:Array):void;
		public function ContextMenu();
		public function hideBuiltInItems():void;
	}
}
