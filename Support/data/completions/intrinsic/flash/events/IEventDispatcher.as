package flash.events {
	public interface IEventDispatcher {
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		public function dispatchEvent(event:Event):Boolean;
		public function hasEventListener(type:String):Boolean;
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		public function willTrigger(type:String):Boolean;
	}
}
