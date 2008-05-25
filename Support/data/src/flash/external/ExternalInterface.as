package flash.external
{
	public final class ExternalInterface
	{
		public var available:Boolean;
		public var objectID:String;
		public static function addCallback(functionName:String, closure:Function):void;
		public static function call(functionName:String, ... arguments):*;
	}
}