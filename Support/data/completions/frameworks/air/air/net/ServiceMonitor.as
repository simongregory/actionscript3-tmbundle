package air.net {
	import flash.events.EventDispatcher;
	public dynamic  class ServiceMonitor extends EventDispatcher {
		public function get available():Boolean;
		public function set available(value:Boolean):void;
		public function get lastStatusUpdate():Date;
		public function get pollInterval():Number;
		public function set pollInterval(value:Number):void;
		public function get running():Boolean;
		public function ServiceMonitor();
		protected function checkStatus():void;
		public static function makeJavascriptSubclass(constructorFunction:Object):void;
		public function start():void;
		public function stop():void;
		public override function toString():String;
	}
}
