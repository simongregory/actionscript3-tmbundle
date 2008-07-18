package flash.events {
	import flash.display.InteractiveObject;
	public class ContextMenuEvent extends Event {
		public function get contextMenuOwner():InteractiveObject;
		public function set contextMenuOwner(value:InteractiveObject):void;
		public function get mouseTarget():InteractiveObject;
		public function set mouseTarget(value:InteractiveObject):void;
		public function ContextMenuEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, mouseTarget:InteractiveObject = null, contextMenuOwner:InteractiveObject = null);
		public override function clone():Event;
		public override function toString():String;
		public static const MENU_ITEM_SELECT:String = "menuItemSelect";
		public static const MENU_SELECT:String = "menuSelect";
	}
}
