package flash.utils
{
	import flash.utils.ByteArray;

	public interface IDataOutput
	{
		public var endian:String;
		public var objectEncoding:uint;
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