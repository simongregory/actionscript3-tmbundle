package flash.net
{
	public final class URLRequest
	{
		public var contentType:String;
		public var data:Object;
		public var method:String;
		public var requestHeaders:Array;
		public var url:String;
		public function URLRequest(url:String = null);
	}
}