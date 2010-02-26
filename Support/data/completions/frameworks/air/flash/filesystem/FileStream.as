package flash.filesystem {
	import flash.events.EventDispatcher;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	public class FileStream extends EventDispatcher implements IDataInput, IDataOutput {
		public function get bytesAvailable():uint;
		public function get endian():String;
		public function set endian(value:String):void;
		public function get objectEncoding():uint;
		public function set objectEncoding(value:uint):void;
		public function get position():Number;
		public function set position(value:Number):void;
		public function get readAhead():Number;
		public function set readAhead(value:Number):void;
		public function FileStream();
		public function close():void;
		public function open(file:File, fileMode:String):void;
		public function openAsync(file:File, fileMode:String):void;
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
		public function truncate():void;
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
