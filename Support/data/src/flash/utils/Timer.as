package flash.utils
{
	import flash.events.EventDispatcher;

	public class Timer extends EventDispatcher
	{
		public var currentCount:int;
		public var delay:Number;
		public var repeatCount:int;
		public var running:Boolean;
		public function Timer(delay:Number, repeatCount:int = 0);
		public function reset():void;
		public function start():void;
		public function stop():void;
	}
}