package flash.system
{
	import flash.system.IME;

	public final class System
	{
		public var ime:IME;
		public var totalMemory:uint;
		public var useCodePage:Boolean;
		public static function setClipboard(string:String):void;
	}
}