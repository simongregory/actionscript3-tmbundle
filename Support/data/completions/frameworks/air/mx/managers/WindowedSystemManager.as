package mx.managers {
	import flash.display.MovieClip;
	import mx.core.IChildList;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.display.DisplayObject;
	public class WindowedSystemManager extends MovieClip implements ISystemManager {
		public function get cursorChildren():IChildList;
		public function get document():Object;
		public function set document(value:Object):void;
		public function get embeddedFontList():Object;
		public function get focusPane():Sprite;
		public function set focusPane(value:Sprite):void;
		public function get height():Number;
		public function get numModalWindows():int;
		public function set numModalWindows(value:int):void;
		public function get popUpChildren():IChildList;
		public function get rawChildren():IChildList;
		public function get screen():Rectangle;
		public function get toolTipChildren():IChildList;
		public function get topLevelSystemManager():ISystemManager;
		public function get width():Number;
		public function activate(f:IFocusManagerContainer):void;
		public function addFocusManager(f:IFocusManagerContainer):void;
		public function create(... params):Object;
		public function deactivate(f:IFocusManagerContainer):void;
		public function getDefinitionByName(name:String):Object;
		public function isFontFaceEmbedded(tf:TextFormat):Boolean;
		public function isTopLevel():Boolean;
		public function isTopLevelWindow(object:DisplayObject):Boolean;
		public function removeFocusManager(f:IFocusManagerContainer):void;
	}
}
