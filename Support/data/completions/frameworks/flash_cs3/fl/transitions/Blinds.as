package fl.transitions
{
import flash.display.MovieClip;
import flash.geom.*;
public class Blinds extends Transition
{
		protected var _numStrips : uint;
		protected var _dimension : uint;
		protected var _mask : MovieClip;
		protected var _innerMask : MovieClip;
		public function get type () : Class;
		internal function Blinds (content:MovieClip, transParams:Object, manager:TransitionManager);
		public function start () : void;
		public function cleanUp () : void;
		protected function _initMask () : void;
		protected function _render (p:Number) : void;
}
}
