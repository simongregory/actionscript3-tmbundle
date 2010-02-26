package air.net {
	import flash.net.URLRequest;
	public class URLMonitor extends ServiceMonitor {
		public function get acceptableStatusCodes():Array;
		public function set acceptableStatusCodes(value:Array):void;
		public function get urlRequest():URLRequest;
		public function URLMonitor(urlRequest:URLRequest, acceptableStatusCodes:Array = null);
		protected override function checkStatus():void;
		public override function toString():String;
	}
}
