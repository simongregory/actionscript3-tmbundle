package flash.media {
	import flash.utils.ByteArray;
	public final  class SoundMixer {
		public static function get bufferTime():int;
		public function set bufferTime(value:int):void;
		public static function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		public static function areSoundsInaccessible():Boolean;
		public static function computeSpectrum(outputArray:ByteArray, FFTMode:Boolean = false, stretchFactor:int = 0):void;
		public static function stopAll():void;
	}
}
