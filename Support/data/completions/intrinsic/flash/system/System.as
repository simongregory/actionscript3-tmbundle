package flash.system {
	public final  class System {
		public static function get ime():IME;
		public static function get totalMemory():uint;
		public static function get useCodePage():Boolean;
		public function set useCodePage(value:Boolean):void;
		public static function exit(code:uint):void;
		public static function gc():void;
		public static function pause():void;
		public static function resume():void;
		public static function setClipboard(string:String):void;
	}
}
