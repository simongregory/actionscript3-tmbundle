package flash.filters {
	public class ConvolutionFilter extends BitmapFilter {
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		public function get bias():Number;
		public function set bias(value:Number):void;
		public function get clamp():Boolean;
		public function set clamp(value:Boolean):void;
		public function get color():uint;
		public function set color(value:uint):void;
		public function get divisor():Number;
		public function set divisor(value:Number):void;
		public function get matrix():Array;
		public function set matrix(value:Array):void;
		public function get matrixX():Number;
		public function set matrixX(value:Number):void;
		public function get matrixY():Number;
		public function set matrixY(value:Number):void;
		public function get preserveAlpha():Boolean;
		public function set preserveAlpha(value:Boolean):void;
		public function ConvolutionFilter(matrixX:Number = 0, matrixY:Number = 0, matrix:Array = null, divisor:Number = 1.0, bias:Number = 0.0, preserveAlpha:Boolean = true, clamp:Boolean = true, color:uint = 0, alpha:Number = 0.0);
		public override function clone():BitmapFilter;
	}
}
