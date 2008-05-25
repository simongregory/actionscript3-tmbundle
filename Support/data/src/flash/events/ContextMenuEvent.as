package flash.events
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.Event;

	public class ContextMenuEvent extends Event
	{
		public var contextMenuOwner:InteractiveObject;
		public var mouseTarget:InteractiveObject;
		public function ContextMenuEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, mouseTarget:InteractiveObject = null, contextMenuOwner:InteractiveObject = null);
		override function clone():Event;
		override function toString():String;
		public static const MENU_ITEM_SELECT:String = "menuItemSelect";
		public static const MENU_SELECT:String = "menuSelect";
	}
}