package flash.net {
	import flash.events.EventDispatcher;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	public class Socket extends EventDispatcher implements IDataInput, IDataOutput {
		public function get bytesAvailable():uint;
		public function get connected():Boolean;
		public function get endian():String;
		public function set endian(value:String):void;
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		public function Socket(host:String = null, port:int = 0);
		public function close():void;
		public function connect(host:String, port:int):void;
		public function flush():void;
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
		public function writeBoolean(value:Boolean):void;
		public function writeByte(value:int):void;
		public function writeBytes(bytes:ByteArray, offset:uint = 0, length:uint = 0):void;
		public function writeDouble(value:Number):void;
		public function writeFloat(value:Number):void;
		public function writeInt(value:int):void;
		public function writeMultiByte(value:String, charSet:String):void;
		public function writeObject(object:*):void;
		public function writeShort(value:int):void;
		public function writeUnsignedInt(value:uint):void;
		public function writeUTF(value:String):void;
		public function writeUTFBytes(value:String):void;
	}
}
