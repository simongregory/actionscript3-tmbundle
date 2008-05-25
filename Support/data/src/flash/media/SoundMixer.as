package flash.media
{
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;

	public final class SoundMixer
	{
		public var bufferTime:int;
		public var soundTransform:SoundTransform;
		public static function areSoundsInaccessible():Boolean;
		public static function computeSpectrum(outputArray:ByteArray, FFTMode:Boolean = false, stretchFactor:int = 0):void;
		public static function stopAll():void;
	}
}