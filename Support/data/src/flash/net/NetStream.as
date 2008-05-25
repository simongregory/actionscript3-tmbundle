package flash.net
{
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.media.Microphone;
	import flash.media.Camera;
	import flash.events.EventDispatcher;

	public class NetStream extends EventDispatcher
	{
		public var bufferLength:Number;
		public var bufferTime:Number;
		public var bytesLoaded:uint;
		public var bytesTotal:uint;
		public var checkPolicyFile:Boolean;
		public var client:Object;
		public var currentFPS:Number;
		public var liveDelay:Number;
		public var objectEncoding:uint;
		public var soundTransform:SoundTransform;
		public var time:Number;
		public function NetStream(connection:NetConnection);
		public function attachAudio(microphone:Microphone):void;
		public function attachCamera(theCamera:Camera, snapshotMilliseconds:int = -1):void;
		public function close():void;
		public function pause():void;
		public function play(... arguments):void;
		public function publish(name:String = null, type:String = null):void;
		public function receiveAudio(flag:Boolean):void;
		public function receiveVideo(flag:Boolean):void;
		public function resume():void;
		public function seek(offset:Number):void;
		public function send(handlerName:String, ... arguments):void;
		public function togglePause():void;
	}
}