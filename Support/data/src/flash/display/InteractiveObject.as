package flash.display
{
	import flash.ui.ContextMenu;
	import flash.display.DisplayObject;

	public class InteractiveObject extends DisplayObject
	{
		public var contextMenu:ContextMenu;
		public var doubleClickEnabled:Boolean;
		public var focusRect:Object;
		public var mouseEnabled:Boolean;
		public var tabEnabled:Boolean;
		public var tabIndex:int;
		public function InteractiveObject();
	}
}