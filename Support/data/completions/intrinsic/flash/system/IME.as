package flash.system {
	import flash.events.EventDispatcher;
	public final  class IME extends EventDispatcher {
		public static function get conversionMode():String;
		public function set conversionMode(value:String):void;
		public static function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		public static function doConversion():void;
		public static function setCompositionString(composition:String):void;
	}
}
