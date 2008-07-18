package flash.net {
	import flash.events.EventDispatcher;
	import flash.media.SoundTransform;
	import flash.media.Microphone;
	import flash.media.Camera;
	public class NetStream extends EventDispatcher {
		public function get bufferLength():Number;
		public function get bufferTime():Number;
		public function set bufferTime(value:Number):void;
		public function get bytesLoaded():uint;
		public function get bytesTotal():uint;
		public function get checkPolicyFile():Boolean;
		public function set checkPolicyFile(value:Boolean):void;
		public function get client():Object;
		public function set client(value:Object):void;
		public function get currentFPS():Number;
		public function get liveDelay():Number;
		public function get objectEncoding():uint;
		public function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		public function get time():Number;
		public function NetStream(connection:NetConnection);
		public function attachAudio(microphone:Microphone):void;
		public function attachCamera(theCamera:Camera, snapshotMilliseconds:int = -1):void;
		public function close():void;
		public function pause():void;
		public function play(... arguments):void;
		public function publish(name:String = null, type:String = null):void;
		public function receiveAudio(flag:Boolean):void;
		public function receiveVideo(flag:Boolean):void;
		public function receiveVideoFPS(FPS:Number):void;
		public function resume():void;
		public function seek(offset:Number):void;
		public function send(handlerName:String, ... arguments):void;
		public function togglePause():void;
	}
}
