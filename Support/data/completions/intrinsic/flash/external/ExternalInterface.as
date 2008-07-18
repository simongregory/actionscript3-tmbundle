package flash.external {
	public final  class ExternalInterface {
		public static function get available():Boolean;
		public static var marshallExceptions:Boolean = false;
		public static function get objectID():String;
		public static function addCallback(functionName:String, closure:Function):void;
		public static function call(functionName:String, ... arguments):*;
	}
}
