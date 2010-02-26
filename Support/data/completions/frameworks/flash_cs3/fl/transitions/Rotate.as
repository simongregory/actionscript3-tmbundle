package fl.transitions
{
import flash.display.*;
public class Rotate extends Transition
{
		protected var _rotationFinal : Number;
		protected var _degrees : Number;
		public function get type () : Class;
		internal function Rotate (content:MovieClip, transParams:Object, manager:TransitionManager);
		protected function _render (p:Number) : void;
}
}
