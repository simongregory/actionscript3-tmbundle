package flash.net {
	import flash.events.EventDispatcher;
	public class URLLoader extends EventDispatcher {
		public var bytesLoaded:uint = 0;
		public var bytesTotal:uint = 0;
		public var data:*;
		public var dataFormat:String = "text";
		public function URLLoader(request:URLRequest = null);
		public function close():void;
		public function load(request:URLRequest):void;
	}
}
