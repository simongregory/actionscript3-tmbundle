package fl.transitions
{
import flash.events.EventDispatcher;
import flash.display.*;
import flash.geom.*;
import flash.events.Event;
public class Transition extends EventDispatcher
{
		public static const IN : uint;
		public static const OUT : uint;
		public var ID : int;
		protected var _content : MovieClip;
		protected var _manager : TransitionManager;
		protected var _direction : uint;
		protected var _duration : Number;
		protected var _easing : Function;
		protected var _progress : Number;
		protected var _innerBounds : Rectangle;
		protected var _outerBounds : Rectangle;
		protected var _width : Number;
		protected var _height : Number;
		protected var _twn : Tween;
		public function get type () : Class;
		public function set manager (mgr:TransitionManager) : Void;
		public function get manager () : TransitionManager;
		public function set content (c:MovieClip) : Void;
		public function get content () : MovieClip;
		public function set direction (direction:Number) : Void;
		public function get direction () : Number;
		public function set duration (d:Number) : Void;
		public function get duration () : Number;
		public function set easing (e:Function) : Void;
		public function get easing () : Function;
		public function set progress (p:Number) : Void;
		public function get progress () : Number;
		internal function Transition (content:MovieClip, transParams:Object, manager:TransitionManager);
		public function start () : void;
		public function stop () : void;
		public function cleanUp () : void;
		public function drawBox (mc:MovieClip, x:Number, y:Number, w:Number, h:Number) : void;
		public function drawCircle (mc:MovieClip, x:Number, y:Number, r:Number) : void;
		protected function _render (p:Number) : void;
		private function _resetTween () : void;
		private function _noEase (t:Number, b:Number, c:Number, d:Number) : Number;
		public function onMotionFinished (src:Object) : void;
}
}
