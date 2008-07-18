package flash.events {
	public class EventDispatcher implements IEventDispatcher {
		public function EventDispatcher(target:IEventDispatcher = null);
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		public function dispatchEvent(event:Event):Boolean;
		public function hasEventListener(type:String):Boolean;
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		public function willTrigger(type:String):Boolean;
	}
}
