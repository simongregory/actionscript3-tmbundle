package flash.filters
{
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilter;

	public final class ColorMatrixFilter extends BitmapFilter
	{
		public var matrix:Array;
		public function ColorMatrixFilter(matrix:Array = null);
		override function clone():BitmapFilter;
	}
}