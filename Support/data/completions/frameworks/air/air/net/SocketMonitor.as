package air.net {
	public class SocketMonitor extends ServiceMonitor {
		public function get host():String;
		public function get port():int;
		public function SocketMonitor(host:String, port:int);
		protected override function checkStatus():void;
		public override function toString():String;
	}
}
