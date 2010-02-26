package fl.transitions
{
import flash.display.MovieClip;
import flash.geom.*;
public class PixelDissolve extends Transition
{
		protected var _xSections : Number;
		protected var _ySections : Number;
		protected var _numSections : uint;
		protected var _indices : Array;
		protected var _mask : MovieClip;
		protected var _innerMask : MovieClip;
		public function get type () : Class;
		internal function PixelDissolve (content:MovieClip, transParams:Object, manager:TransitionManager);
		public function start () : void;
		public function cleanUp () : void;
		protected function _initMask () : void;
		protected function _shuffleArray (a:Array) : void;
		protected function _render (p:Number) : void;
}
}
