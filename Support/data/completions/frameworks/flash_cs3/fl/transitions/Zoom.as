package fl.transitions
{
import flash.display.MovieClip;
public class Zoom extends Transition
{
		protected var _scaleXFinal : Number;
		protected var _scaleYFinal : Number;
		public function get type () : Class;
		internal function Zoom (content:MovieClip, transParams:Object, manager:TransitionManager);
		protected function _render (p:Number) : void;
}
}
