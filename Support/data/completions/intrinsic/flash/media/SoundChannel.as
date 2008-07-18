package flash.media {
	import flash.events.EventDispatcher;
	public final  class SoundChannel extends EventDispatcher {
		public function get leftPeak():Number;
		public function get position():Number;
		public function get rightPeak():Number;
		public function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		public function stop():void;
	}
}
