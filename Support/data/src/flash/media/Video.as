package flash.media
{
	import flash.media.Camera;
	import flash.net.NetStream;
	import flash.display.DisplayObject;

	public class Video extends DisplayObject
	{
		public var deblocking:int;
		public var smoothing:Boolean;
		public var videoHeight:int;
		public var videoWidth:int;
		public function Video(width:int = 320, height:int = 240);
		public function attachCamera(camera:Camera):void;
		public function attachNetStream(netStream:NetStream):void;
		public function clear():void;
	}
}