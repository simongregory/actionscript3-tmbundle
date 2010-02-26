package fl.transitions
{
import flash.display.MovieClip;
import flash.geom.*;
public class Photo extends Transition
{
		protected var _alphaFinal : Number;
		protected var _colorControl : ColorTransform;
		public function get type () : Class;
		internal function Photo (content:MovieClip, transParams:Object, manager:TransitionManager);
		protected function _render (p:Number) : void;
}
}
