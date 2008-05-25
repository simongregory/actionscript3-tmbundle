package flash.ui
{
	import flash.ui.ContextMenuBuiltInItems;
	import flash.events.EventDispatcher;

	public final class ContextMenu extends EventDispatcher
	{
		public var builtInItems:ContextMenuBuiltInItems;
		public var customItems:Array;
		public function ContextMenu();
		public function clone():ContextMenu;
		public function hideBuiltInItems():void;
	}
}