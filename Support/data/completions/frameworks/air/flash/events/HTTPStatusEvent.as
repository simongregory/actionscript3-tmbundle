package flash.events {
	public class HTTPStatusEvent extends Event {
		public function get responseHeaders():Array;
		public function set responseHeaders(value:Array):void;
		public function get responseURL():String;
		public function set responseURL(value:String):void;
		public function get status():int;
		public function HTTPStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, status:int = 0);
		public override function clone():Event;
		public override function toString():String;
		public static const HTTP_RESPONSE_STATUS:String = "httpResponseStatus";
		public static const HTTP_STATUS:String = "httpStatus";
	}
}
