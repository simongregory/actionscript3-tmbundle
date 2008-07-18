package flash.display {
	public dynamic  class MovieClip extends Sprite {
		public function get currentFrame():int;
		public function get currentLabel():String;
		public function get currentLabels():Array;
		public function get currentScene():Scene;
		public function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		public function get framesLoaded():int;
		public function get scenes():Array;
		public function get totalFrames():int;
		public function get trackAsMenu():Boolean;
		public function set trackAsMenu(value:Boolean):void;
		public function MovieClip();
		public function gotoAndPlay(frame:Object, scene:String = null):void;
		public function gotoAndStop(frame:Object, scene:String = null):void;
		public function nextFrame():void;
		public function nextScene():void;
		public function play():void;
		public function prevFrame():void;
		public function prevScene():void;
		public function stop():void;
		// NON-DOCUMENTED (MANUAL ADDITION)
		public function addFrameScript(frame:uint, notify:Function):void;
	}
}
