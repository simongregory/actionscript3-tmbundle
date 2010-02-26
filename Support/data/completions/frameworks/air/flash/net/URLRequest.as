package flash.net {
	public final  class URLRequest {
		public function get authenticate():Boolean;
		public function set authenticate(value:Boolean):void;
		public function get cacheResponse():Boolean;
		public function set cacheResponse(value:Boolean):void;
		public function get contentType():String;
		public function set contentType(value:String):void;
		public function get data():Object;
		public function set data(value:Object):void;
		public function get digest():String;
		public function set digest(value:String):void;
		public function get followRedirects():Boolean;
		public function set followRedirects(value:Boolean):void;
		public function get manageCookies():Boolean;
		public function set manageCookies(value:Boolean):void;
		public function get method():String;
		public function set method(value:String):void;
		public function get requestHeaders():Array;
		public function set requestHeaders(value:Array):void;
		public function get url():String;
		public function set url(value:String):void;
		public function get useCache():Boolean;
		public function set useCache(value:Boolean):void;
		public function get userAgent():String;
		public function set userAgent(value:String):void;
		public function URLRequest(url:String = null);
	}
}
