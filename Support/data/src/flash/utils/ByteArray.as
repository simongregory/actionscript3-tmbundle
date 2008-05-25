package flash.utils
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class ByteArray implements IDataInput, IDataOutput
	{
		public var bytesAvailable:uint;
		public var defaultObjectEncoding:uint;
		public var endian:String;
		public var length:uint;
		public var objectEncoding:uint;
		public var position:uint;
		public function ByteArray();
		public function compress():void;
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
		public function toString():String;
		public function uncompress():void;
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