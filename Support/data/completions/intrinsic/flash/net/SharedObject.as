package flash.net {
	import flash.events.EventDispatcher;
	public class SharedObject extends EventDispatcher {
		public function get client():Object;
		public function set client(value:Object):void;
		public function get data():Object;
		public static function get defaultObjectEncoding():uint;
		public function set defaultObjectEncoding(value:uint):void;
		public function set fps(value:Number):void;
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		public function get size():uint;
		public function clear():void;
		public function close():void;
		public function connect(myConnection:NetConnection, params:String = null):void;
		public function flush(minDiskSpace:int = 0):String;
		public static function getLocal(name:String, localPath:String = null, secure:Boolean = false):SharedObject;
		public static function getRemote(name:String, remotePath:String = null, persistence:Object = false, secure:Boolean = false):SharedObject;
		public function send(... arguments):void;
		public function setDirty(propertyName:String):void;
		public function setProperty(propertyName:String, value:Object = null):void;
	}
}
