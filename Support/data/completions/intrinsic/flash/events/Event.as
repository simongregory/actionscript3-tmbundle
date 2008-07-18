package flash.events {
	public class Event {
		public function get bubbles():Boolean;
		public function get cancelable():Boolean;
		public function get currentTarget():Object;
		public function get eventPhase():uint;
		public function get target():Object;
		public function get type():String;
		public function Event(type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		public function clone():Event;
		public function formatToString(className:String, ... arguments):String;
		public function isDefaultPrevented():Boolean;
		public function preventDefault():void;
		public function stopImmediatePropagation():void;
		public function stopPropagation():void;
		public function toString():String;
		public static const ACTIVATE:String = "activate";
		public static const ADDED:String = "added";
		public static const ADDED_TO_STAGE:String = "addedToStage";
		public static const CANCEL:String = "cancel";
		public static const CHANGE:String = "change";
		public static const CLOSE:String = "close";
		public static const COMPLETE:String = "complete";
		public static const CONNECT:String = "connect";
		public static const DEACTIVATE:String = "deactivate";
		public static const ENTER_FRAME:String = "enterFrame";
		public static const FULLSCREEN:String = "fullScreen";
		public static const ID3:String = "id3";
		public static const INIT:String = "init";
		public static const MOUSE_LEAVE:String = "mouseLeave";
		public static const OPEN:String = "open";
		public static const REMOVED:String = "removed";
		public static const REMOVED_FROM_STAGE:String = "removedFromStage";
		public static const RENDER:String = "render";
		public static const RESIZE:String = "resize";
		public static const SCROLL:String = "scroll";
		public static const SELECT:String = "select";
		public static const SOUND_COMPLETE:String = "soundComplete";
		public static const TAB_CHILDREN_CHANGE:String = "tabChildrenChange";
		public static const TAB_ENABLED_CHANGE:String = "tabEnabledChange";
		public static const TAB_INDEX_CHANGE:String = "tabIndexChange";
		public static const UNLOAD:String = "unload";
	}
}
