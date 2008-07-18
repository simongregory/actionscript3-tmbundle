package flash.media {
	import flash.events.EventDispatcher;
	public final  class Microphone extends EventDispatcher {
		public function get activityLevel():Number;
		public function get gain():Number;
		public function set gain(value:Number):void;
		public function get index():int;
		public function get muted():Boolean;
		public function get name():String;
		public static function get names():Array;
		public function get rate():int;
		public function set rate(value:int):void;
		public function get silenceLevel():Number;
		public function get silenceTimeout():int;
		public function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		public function get useEchoSuppression():Boolean;
		public static function getMicrophone(index:int = 0):Microphone;
		public function setLoopBack(state:Boolean = true):void;
		public function setSilenceLevel(silenceLevel:Number, timeout:int = -1):void;
		public function setUseEchoSuppression(useEchoSuppression:Boolean):void;
	}
}
