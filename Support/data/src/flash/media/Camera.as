package flash.media
{
	import flash.events.EventDispatcher;

	public final class Camera extends EventDispatcher
	{
		public var activityLevel:Number;
		public var bandwidth:int;
		public var currentFPS:Number;
		public var fps:Number;
		public var height:int;
		public var index:int;
		public var keyFrameInterval:int;
		public var loopback:Boolean;
		public var motionLevel:int;
		public var motionTimeout:int;
		public var muted:Boolean;
		public var name:String;
		public var names:Array;
		public var quality:int;
		public var width:int;
		public static function getCamera(name:String = null):Camera;
		public function setKeyFrameInterval(keyFrameInterval:int):void;
		public function setLoopback(compress:Boolean = false):void;
		public function setMode(width:int, height:int, fps:Number, favorArea:Boolean = true):void;
		public function setMotionLevel(motionLevel:int, timeout:int = 2000):void;
		public function setQuality(bandwidth:int, quality:int):void;
	}
}