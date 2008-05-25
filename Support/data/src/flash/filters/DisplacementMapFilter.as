package flash.filters
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilter;

	public final class DisplacementMapFilter extends BitmapFilter
	{
		public var alpha:Number;
		public var color:uint;
		public var componentX:uint;
		public var componentY:uint;
		public var mapBitmap:BitmapData;
		public var mapPoint:Point;
		public var mode:String;
		public var scaleX:Number;
		public var scaleY:Number;
		public function DisplacementMapFilter(mapBitmap:BitmapData = null, mapPoint:Point = null, componentX:uint = 0, componentY:uint = 0, scaleX:Number = 0.0, scaleY:Number = 0.0, mode:String = "wrap", color:uint = 0, alpha:Number = 0.0);
		override function clone():BitmapFilter;
	}
}