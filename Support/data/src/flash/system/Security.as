package flash.system
{
	public final class Security
	{
		public var exactSettings:Boolean;
		public var sandboxType:String;
		public static function allowDomain(... domains):void;
		public static function allowInsecureDomain(... domains):void;
		public static function loadPolicyFile(url:String):void;
		public static function showSettings(panel:String = "default"):void;
		public static const LOCAL_TRUSTED:String = "localTrusted";
		public static const LOCAL_WITH_FILE:String = "localWithFile";
		public static const LOCAL_WITH_NETWORK:String = "localWithNetwork";
		public static const REMOTE:String = "remote";
	}
}