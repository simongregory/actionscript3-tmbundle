package flash.display {
	import flash.events.EventDispatcher;
	public class NativeMenuItem extends EventDispatcher {
		public function get checked():Boolean;
		public function set checked(value:Boolean):void;
		public function get data():Object;
		public function set data(value:Object):void;
		public function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		public function get isSeparator():Boolean;
		public function get keyEquivalent():String;
		public function set keyEquivalent(value:String):void;
		public function get keyEquivalentModifiers():Array;
		public function set keyEquivalentModifiers(value:Array):void;
		public function get label():String;
		public function set label(value:String):void;
		public function get menu():NativeMenu;
		public function get mnemonicIndex():int;
		public function set mnemonicIndex(value:int):void;
		public function get name():String;
		public function set name(value:String):void;
		public function get submenu():NativeMenu;
		public function set submenu(value:NativeMenu):void;
		public function NativeMenuItem(label:String = "", isSeparator:Boolean = false);
		public function clone():NativeMenuItem;
		public override function toString():String;
	}
}
