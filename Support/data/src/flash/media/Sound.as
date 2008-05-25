package flash.media
{
	import flash.media.ID3Info;
	import flash.net.URLRequest;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	import flash.events.EventDispatcher;

	public class Sound extends EventDispatcher
	{
		public var bytesLoaded:uint;
		public var bytesTotal:int;
		public var id3:ID3Info;
		public var isBuffering:Boolean;
		public var length:Number;
		public var url:String;
		public function Sound(stream:URLRequest = null, context:SoundLoaderContext = null);
		public function close():void;
		public function load(stream:URLRequest, context:SoundLoaderContext = null):void;
		public function play(startTime:Number = 0, loops:int = 0, sndTransform:SoundTransform = null):SoundChannel;
	}
}