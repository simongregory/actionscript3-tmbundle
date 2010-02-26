package mx.events {
	import flash.events.Event;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	public class FlexNativeMenuEvent extends Event {
		public var index:int;
		public var item:Object;
		public var label:String;
		public var nativeMenu:NativeMenu;
		public var nativeMenuItem:NativeMenuItem;
		public function FlexNativeMenuEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, nativeMenu:NativeMenu = null, nativeMenuItem:NativeMenuItem = null, item:Object = null, label:String = null, index:int = -1);
		public static const ITEM_CLICK:String = "itemClick";
		public static const MENU_SHOW:String = "menuShow";
	}
}
