package flash.display {
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	public final  class Screen extends EventDispatcher {
		public function get bounds():Rectangle;
		public function get colorDepth():int;
		public static function get mainScreen():Screen;
		public static function get screens():Array;
		public function get visibleBounds():Rectangle;
		public static function getScreensForRectangle(rect:Rectangle):Array;
	}
}
