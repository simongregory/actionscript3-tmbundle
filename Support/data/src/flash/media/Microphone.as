package flash.media
{
	import flash.media.SoundTransform;
	import flash.events.EventDispatcher;

	public final class Microphone extends EventDispatcher
	{
		public var activityLevel:Number;
		public var gain:Number;
		public var index:int;
		public var muted:Boolean;
		public var name:String;
		public var names:Array;
		public var rate:int;
		public var silenceLevel:Number;
		public var silenceTimeout:int;
		public var soundTransform:SoundTransform;
		public var useEchoSuppression:Boolean;
		public static function getMicrophone(index:int = 0):Microphone;
		public function setLoopBack(state:Boolean = true):void;
		public function setSilenceLevel(silenceLevel:Number, timeout:int = -1):void;
		public function setUseEchoSuppression(useEchoSuppression:Boolean):void;
	}
}