package flash.system {
	public final  class Security {
		public static function get exactSettings():Boolean;
		public function set exactSettings(value:Boolean):void;
		public static function get sandboxType():String;
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
