package flash.media {
	import flash.display.DisplayObject;
	import flash.net.NetStream;
	public class Video extends DisplayObject {
		public function get deblocking():int;
		public function set deblocking(value:int):void;
		public function get smoothing():Boolean;
		public function set smoothing(value:Boolean):void;
		public function get videoHeight():int;
		public function get videoWidth():int;
		public function Video(width:int = 320, height:int = 240);
		public function attachCamera(camera:Camera):void;
		public function attachNetStream(netStream:NetStream):void;
		public function clear():void;
	}
}
