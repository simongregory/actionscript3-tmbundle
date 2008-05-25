package flash.net
{
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.events.EventDispatcher;
	import flash.utils.IDataInput;

	public class URLStream extends EventDispatcher implements IDataInput
	{
		public var bytesAvailable:uint;
		public var connected:Boolean;
		public var endian:String;
		public var objectEncoding:uint;
		public function close():void;
		public function load(request:URLRequest):void;
		public function readBoolean():Boolean;
		public function readByte():int;
		public function readBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void;
		public function readDouble():Number;
		public function readFloat():Number;
		public function readInt():int;
		public function readMultiByte(length:uint, charSet:String):String;
		public function readObject():*;
		public function readShort():int;
		public function readUnsignedByte():uint;
		public function readUnsignedInt():uint;
		public function readUnsignedShort():uint;
		public function readUTF():String;
		public function readUTFBytes(length:uint):String;
	}
}