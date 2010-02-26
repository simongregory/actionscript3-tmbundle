package fl.transitions
{
import flash.display.*;
public class Fade extends Transition
{
		protected var _alphaFinal : Number;
		public function get type () : Class;
		internal function Fade (content:MovieClip, transParams:Object, manager:TransitionManager);
		protected function _render (p:Number) : void;
}
}
