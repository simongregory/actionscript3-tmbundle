package flash.desktop {
	import flash.events.EventDispatcher;
	import flash.display.NativeWindow;
	import flash.display.NativeMenu;
	import flash.events.Event;
	public final  class NativeApplication extends EventDispatcher {
		public function get activeWindow():NativeWindow;
		public function get applicationDescriptor():XML;
		public function get applicationID():String;
		public function get autoExit():Boolean;
		public function set autoExit(value:Boolean):void;
		public function get icon():InteractiveIcon;
		public function get idleThreshold():int;
		public function set idleThreshold(value:int):void;
		public function get menu():NativeMenu;
		public function set menu(value:NativeMenu):void;
		public static function get nativeApplication():NativeApplication;
		public function get openedWindows():Array;
		public function get publisherID():String;
		public function get runtimePatchLevel():uint;
		public function get runtimeVersion():String;
		public function get startAtLogin():Boolean;
		public function set startAtLogin(value:Boolean):void;
		public static function get supportsDockIcon():Boolean;
		public static function get supportsMenu():Boolean;
		public static function get supportsSystemTrayIcon():Boolean;
		public function get timeSinceLastUserInput():int;
		public function activate(window:NativeWindow = null):void;
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		public function clear():Boolean;
		public function copy():Boolean;
		public function cut():Boolean;
		public override function dispatchEvent(event:Event):Boolean;
		public function exit(errorCode:int = 0):void;
		public function getDefaultApplication(extension:String):String;
		public function isSetAsDefaultApplication(extension:String):Boolean;
		public function paste():Boolean;
		public function removeAsDefaultApplication(extension:String):void;
		public override function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		public function selectAll():Boolean;
		public function setAsDefaultApplication(extension:String):void;
	}
}
