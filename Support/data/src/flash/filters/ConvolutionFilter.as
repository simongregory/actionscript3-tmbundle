package flash.filters
{
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilter;

	public class ConvolutionFilter extends BitmapFilter
	{
		public var alpha:Number;
		public var bias:Number;
		public var clamp:Boolean;
		public var color:uint;
		public var divisor:Number;
		public var matrix:Array;
		public var matrixX:Number;
		public var matrixY:Number;
		public var preserveAlpha:Boolean;
		public function ConvolutionFilter(matrixX:Number = 0, matrixY:Number = 0, matrix:Array = null, divisor:Number = 1.0, bias:Number = 0.0, preserveAlpha:Boolean = true, clamp:Boolean = true, color:uint = 0, alpha:Number = 0.0);
		override function clone():BitmapFilter;
	}
}