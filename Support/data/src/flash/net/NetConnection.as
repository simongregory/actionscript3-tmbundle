package flash.net
{
	import flash.net.Responder;
	import flash.events.EventDispatcher;

	public class NetConnection extends EventDispatcher
	{
		public var client:Object;
		public var connected:Boolean;
		public var connectedProxyType:String;
		public var defaultObjectEncoding:uint;
		public var objectEncoding:uint;
		public var proxyType:String;
		public var uri:String;
		public var usingTLS:Boolean;
		public function NetConnection();
		public function addHeader(operation:String, mustUnderstand:Boolean = false, param:Object = null):void;
		public function call(command:String, responder:Responder, ... arguments):void;
		public function close():void;
		public function connect(command:String, ... arguments):void;
	}
}