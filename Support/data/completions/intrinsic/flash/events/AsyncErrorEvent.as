package flash.events {
	public class AsyncErrorEvent extends ErrorEvent {
		public var error:Error;
		public function AsyncErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", error:Error = null);
		public override function clone():Event;
		public override function toString():String;
		public static const ASYNC_ERROR:String = "asyncError";
	}
}
