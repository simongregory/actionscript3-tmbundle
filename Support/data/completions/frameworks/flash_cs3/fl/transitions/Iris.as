package fl.transitions
{
import flash.display.MovieClip;
import flash.geom.*;
public class Iris extends Transition
{
		public static const SQUARE : String;
		public static const CIRCLE : String;
		protected var _mask : MovieClip;
		protected var _startPoint : uint;
		protected var _cornerMode : Boolean;
		protected var _shape : String;
		protected var _maxDimension : Number;
		protected var _minDimension : Number;
		protected var _renderFunction : Function;
		public function get type () : Class;
		internal function Iris (content:MovieClip, transParams:Object, manager:TransitionManager);
		public function start () : void;
		public function cleanUp () : void;
		protected function _initMask () : void;
		protected function _render (p:Number) : void;
		protected function _renderCircle (p:Number) : void;
		protected function _drawQuarterCircle (mc:MovieClip, r:Number) : void;
		protected function _drawHalfCircle (mc:MovieClip, r:Number) : void;
		protected function _renderSquareEdge (p:Number) : void;
		protected function _renderSquareCorner (p:Number) : void;
}
}
