package flash.utils {
	import flash.events.EventDispatcher;
	public class Timer extends EventDispatcher {
		public function get currentCount():int;
		public function get delay():Number;
		public function set delay(value:Number):void;
		public function get repeatCount():int;
		public function set repeatCount(value:int):void;
		public function get running():Boolean;
		public function Timer(delay:Number, repeatCount:int = 0);
		public function reset():void;
		public function start():void;
		public function stop():void;
	}
}
