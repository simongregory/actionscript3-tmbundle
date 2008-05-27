package flash.display
{
	import flash.display.InteractiveObject;
	import flash.text.TextSnapshot;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.display.DisplayObjectContainer;

	public class Stage extends DisplayObjectContainer
	{
		public var align:String;
        public var displayState:String;
        public var focus:InteractiveObject;
        public var frameRate:Number;
        public var fullScreenHeight:uint;
        public var fullScreenSourceRect:Rectangle;
        public var fullScreenWidth:uint;
        public var height:Number;
        public var mouseChildren:Boolean;
        public var numChildren:int;
        public var quality:String;
        public var scaleMode:String;
        public var showDefaultContextMenu:Boolean;
        public var stageFocusRect:Boolean;
        public var stageHeight:int;
        public var stageWidth:int;
        public var tabChildren:Boolean;
        public var textSnapshot:TextSnapshot;
        public var width:Number;
		override function addChild(child:DisplayObject):DisplayObject;
		override function addChildAt(child:DisplayObject, index:int):DisplayObject;
		override function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		override function dispatchEvent(event:Event):Boolean;
		override function hasEventListener(type:String):Boolean;
		public function invalidate():void;
		public function isFocusInaccessible():Boolean;
		override function removeChildAt(index:int):DisplayObject;
		override function setChildIndex(child:DisplayObject, index:int):void;
		override function swapChildrenAt(index1:int, index2:int):void;
		override function willTrigger(type:String):Boolean;
	}
}