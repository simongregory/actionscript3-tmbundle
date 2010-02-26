package flash.net {
	public class URLRequestDefaults {
		public static function get authenticate():Boolean;
		public function set authenticate(value:Boolean):void;
		public static function get cacheResponse():Boolean;
		public function set cacheResponse(value:Boolean):void;
		public static function get followRedirects():Boolean;
		public function set followRedirects(value:Boolean):void;
		public static function get manageCookies():Boolean;
		public function set manageCookies(value:Boolean):void;
		public static function get useCache():Boolean;
		public function set useCache(value:Boolean):void;
		public static function get userAgent():String;
		public function set userAgent(value:String):void;
		public static function setLoginCredentialsForHost(hostname:String, user:String, password:String):*;
	}
}
