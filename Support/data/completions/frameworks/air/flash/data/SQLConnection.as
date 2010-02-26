package flash.data {
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	public class SQLConnection extends EventDispatcher {
		public function get autoCompact():Boolean;
		public function get cacheSize():uint;
		public function set cacheSize(value:uint):void;
		public function get columnNameStyle():String;
		public function set columnNameStyle(value:String):void;
		public function get connected():Boolean;
		public function get inTransaction():Boolean;
		public function get lastInsertRowID():Number;
		public function get pageSize():uint;
		public function get totalChanges():Number;
		public function SQLConnection();
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		public function analyze(resourceName:String = null, responder:Responder = null):void;
		public function attach(name:String, reference:Object = null, responder:Responder = null):void;
		public function begin(option:String = null, responder:Responder = null):void;
		public function cancel(responder:Responder = null):void;
		public function close(responder:Responder = null):void;
		public function commit(responder:Responder = null):void;
		public function compact(responder:Responder = null):void;
		public function deanalyze(responder:Responder = null):void;
		public function detach(name:String, responder:Responder = null):void;
		public function getSchemaResult():SQLSchemaResult;
		public function loadSchema(type:Class = null, name:String = null, database:String = "main", includeColumnSchema:Boolean = true, responder:Responder = null):void;
		public function open(reference:Object = null, openMode:String = "create", autoCompact:Boolean = false, pageSize:int = 1024):void;
		public function openAsync(reference:Object = null, openMode:String = "create", responder:Responder = null, autoCompact:Boolean = false, pageSize:int = 1024):void;
		public override function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		public function rollback(responder:Responder = null):void;
	}
}
