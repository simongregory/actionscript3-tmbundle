package flash.display
{
	import flash.display.Scene;
	import flash.display.Sprite;

	public dynamic class MovieClip extends Sprite
	{
		public var currentFrame:int;
		public var currentLabel:String;
		public var currentLabels:Array;
		public var currentScene:Scene;
		public var enabled:Boolean;
		public var framesLoaded:int;
		public var scenes:Array;
		public var totalFrames:int;
		public var trackAsMenu:Boolean;
		public function MovieClip();
		public function gotoAndPlay(frame:Object, scene:String = null):void;
		public function gotoAndStop(frame:Object, scene:String = null):void;
		public function nextFrame():void;
		public function nextScene():void;
		public function play():void;
		public function prevFrame():void;
		public function prevScene():void;
		public function stop():void;
	}
}