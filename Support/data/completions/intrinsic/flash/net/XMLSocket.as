package flash.net {
	import flash.events.EventDispatcher;
	public class XMLSocket extends EventDispatcher {
		public function get connected():Boolean;
		public function XMLSocket(host:String = null, port:int = 0);
		public function close():void;
		public function connect(host:String, port:int):void;
		public function send(object:*):void;
	}
}
