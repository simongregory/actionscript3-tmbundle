package fl.transitions
{
import flash.events.*;
import flash.display.*;
import flash.utils.*;
public class Tween extends EventDispatcher
{
		protected static var _mc : MovieClip;
		public var isPlaying : Boolean;
		public var obj : Object;
		public var prop : String;
		public var begin : Number;
		public var change : Number;
		public var useSeconds : Boolean;
		public var prevTime : Number;
		public var prevPos : Number;
		public var looping : Boolean;
		private var _duration : Number;
		private var _time : Number;
		private var _fps : Number;
		private var _position : Number;
		private var _startTime : Number;
		private var _intervalID : uint;
		private var _finish : Number;
		private var _timer : Timer;
		public function get time () : Number;
		public function set time (t:Number) : Void;
		public function get duration () : Number;
		public function set duration (d:Number) : Void;
		public function get FPS () : Number;
		public function set FPS (fps:Number) : Void;
		public function get position () : Number;
		public function set position (p:Number) : Void;
		public function get finish () : Number;
		public function set finish (value:Number) : Void;
		public function func (t:Number, b:Number, c:Number, d:Number) : Number;
		public function getPosition (t:Number =NaN) : Number;
		public function setPosition (p:Number) : void;
		internal function Tween (obj:Object, prop:String, func:Function, begin:Number, finish:Number, duration:Number, useSeconds:Boolean =false);
		public function continueTo (finish:Number, duration:Number) : void;
		public function yoyo () : void;
		protected function startEnterFrame () : void;
		protected function stopEnterFrame () : void;
		public function start () : void;
		public function stop () : void;
		public function resume () : void;
		public function rewind (t:Number =0) : void;
		public function fforward () : void;
		public function nextFrame () : void;
		protected function onEnterFrame (event:Event) : void;
		protected function timerHandler (timerEvent:TimerEvent) : void;
		public function prevFrame () : void;
		private function fixTime () : void;
		private function update () : void;
}
}
