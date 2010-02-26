package fl.transitions
{
import flash.display.*;
import flash.geom.*;
public class Fly extends Transition
{
		public var className : String;
		protected var _startPoint : Number;
		protected var _xFinal : Number;
		protected var _yFinal : Number;
		protected var _xInitial : Number;
		protected var _yInitial : Number;
		protected var _stagePoints : Object;
		public function get type () : Class;
		internal function Fly (content:MovieClip, transParams:Object, manager:TransitionManager);
		protected function _render (p:Number) : void;
}
}
