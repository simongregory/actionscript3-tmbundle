package flash.filters
{
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilter;

	public final class BlurFilter extends BitmapFilter
	{
		public var blurX:Number;
		public var blurY:Number;
		public var quality:int;
		public function BlurFilter(blurX:Number = 4.0, blurY:Number = 4.0, quality:int = 1);
		override function clone():BitmapFilter;
	}
}