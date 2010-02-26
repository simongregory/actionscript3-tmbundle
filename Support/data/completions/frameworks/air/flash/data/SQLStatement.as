package flash.data {
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	public class SQLStatement extends EventDispatcher {
		public function get executing():Boolean;
		public function get itemClass():Class;
		public function set itemClass(value:Class):void;
		public function get parameters():Object;
		public function get sqlConnection():SQLConnection;
		public function set sqlConnection(value:SQLConnection):void;
		public function get text():String;
		public function set text(value:String):void;
		public function SQLStatement();
		public function cancel():void;
		public function clearParameters():void;
		public function execute(prefetch:int = -1, responder:Responder = null):void;
		public function getResult():SQLResult;
		public function next(prefetch:int = -1, responder:Responder = null):void;
	}
}
