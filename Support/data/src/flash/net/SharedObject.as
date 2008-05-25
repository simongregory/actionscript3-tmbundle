package flash.net
{
	import flash.net.NetConnection;
	import flash.events.EventDispatcher;

	public class SharedObject extends EventDispatcher
	{
		public var client:Object;
		public var data:Object;
		public var defaultObjectEncoding:uint;
		public var fps:Number;
		public var objectEncoding:uint;
		public var size:uint;
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