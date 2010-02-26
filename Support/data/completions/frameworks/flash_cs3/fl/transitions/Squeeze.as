package fl.transitions
{
import flash.display.MovieClip;
public class Squeeze extends Transition
{
		protected var _scaleProp : String;
		protected var _scaleFinal : Number;
		public function get type () : Class;
		internal function Squeeze (content:MovieClip, transParams:Object, manager:TransitionManager);
		protected function _render (p:Number) : void;
}
}
