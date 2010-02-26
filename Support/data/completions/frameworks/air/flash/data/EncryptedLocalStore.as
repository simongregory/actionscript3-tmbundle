package flash.data {
	import flash.utils.ByteArray;
	public class EncryptedLocalStore {
		public static function getItem(name:String):ByteArray;
		public static function removeItem(name:String):void;
		public static function reset():void;
		public static function setItem(name:String, data:ByteArray, stronglyBound:Boolean = false):void;
	}
}
