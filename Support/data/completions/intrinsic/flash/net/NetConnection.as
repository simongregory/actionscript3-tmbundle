package flash.net {
	import flash.events.EventDispatcher;
	public class NetConnection extends EventDispatcher {
		public function get client():Object;
		public function set client(value:Object):void;
		public function get connected():Boolean;
		public function get connectedProxyType():String;
		public static function get defaultObjectEncoding():uint;
		public function set defaultObjectEncoding(value:uint):void;
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		public function get proxyType():String;
		public function set proxyType(value:String):void;
		public function get uri():String;
		public function get usingTLS():Boolean;
		public function NetConnection();
		public function addHeader(operation:String, mustUnderstand:Boolean = false, param:Object = null):void;
		public function call(command:String, responder:Responder, ... arguments):void;
		public function close():void;
		public function connect(command:String, ... arguments):void;
	}
}
