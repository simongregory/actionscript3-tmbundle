package flash.media
{
	import flash.media.SoundTransform;
	import flash.events.EventDispatcher;

	public final class SoundChannel extends EventDispatcher
	{
		public var leftPeak:Number;
		public var position:Number;
		public var rightPeak:Number;
		public var soundTransform:SoundTransform;
		public function stop():void;
	}
}