package flash.net
{
	import flash.events.EventDispatcher;

	public class LocalConnection extends EventDispatcher
	{
		public var client:Object;
		public var domain:String;
		public function LocalConnection();
		public function allowDomain(... domains):void;
		public function allowInsecureDomain(... domains):void;
		public function close():void;
		public function connect(connectionName:String):void;
		public function send(connectionName:String, methodName:String, ... arguments):void;
	}
}