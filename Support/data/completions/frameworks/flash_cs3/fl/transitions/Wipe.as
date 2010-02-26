package fl.transitions
{
import flash.display.MovieClip;
import flash.geom.*;
public class Wipe extends Transition
{
		protected var _mask : MovieClip;
		protected var _innerMask : MovieClip;
		protected var _startPoint : uint;
		protected var _cornerMode : Boolean;
		public function get type () : Class;
		internal function Wipe (content:MovieClip, transParams:Object, manager:TransitionManager);
		public function start () : void;
		public function cleanUp () : void;
		protected function _initMask () : void;
		protected function _render (p:Number) : void;
		protected function _drawSlant (mc:MovieClip, p:Number) : void;
}
}
