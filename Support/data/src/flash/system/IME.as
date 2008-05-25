package flash.system
{
	import flash.events.EventDispatcher;

	public final class IME extends EventDispatcher
	{
		public var conversionMode:String;
		public var enabled:Boolean;
		public static function doConversion():void;
		public static function setCompositionString(composition:String):void;
	}
}