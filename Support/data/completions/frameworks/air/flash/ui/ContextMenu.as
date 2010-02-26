package flash.ui {
	import flash.display.NativeMenu;
	import flash.display.Stage;
	public final  class ContextMenu extends NativeMenu {
		public function get builtInItems():ContextMenuBuiltInItems;
		public function set builtInItems(value:ContextMenuBuiltInItems):void;
		public function get customItems():Array;
		public function set customItems(value:Array):void;
		public function ContextMenu();
		public override function display(stage:Stage, stageX:Number, stageY:Number):void;
		public function hideBuiltInItems():void;
	}
}
