package fl.motion
{
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.ColorTransform;
public class Animator extends EventDispatcher
{
		private var _motion : Motion;
		public var orientToPath : Boolean;
		public var transformationPoint : Point;
		public var autoRewind : Boolean;
		public var positionMatrix : Matrix;
		public var repeatCount : int;
		private var _isPlaying : Boolean;
		private var _target : DisplayObject;
		private var _lastRenderedTime : int;
		private var _time : int;
		private var playCount : int;
		private static var enterFrameBeacon : MovieClip;
		private var targetState : Object;
		public function get motion () : Motion;
		public function set motion (value:Motion) : Void;
		public function get isPlaying () : Boolean;
		public function get target () : DisplayObject;
		public function set target (value:DisplayObject) : Void;
		public function get time () : int;
		public function set time (newTime:int) : Void;
		internal function Animator (xml:XML =null, target:DisplayObject =null);
		public static function fromXMLString (xmlString:String, target:DisplayObject =null) : Animator;
		public function nextFrame () : void;
		public function play () : void;
		public function end () : void;
		public function stop () : void;
		public function pause () : void;
		public function resume () : void;
		public function rewind () : void;
		private function handleLastFrame () : void;
		private function enterFrameHandler (event:Event) : void;
}
}
