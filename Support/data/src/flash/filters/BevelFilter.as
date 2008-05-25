package flash.filters
{
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilter;

	public final class BevelFilter extends BitmapFilter
	{
		public var angle:Number;
		public var blurX:Number;
		public var blurY:Number;
		public var distance:Number;
		public var highlightAlpha:Number;
		public var highlightColor:uint;
		public var knockout:Boolean;
		public var quality:int;
		public var shadowAlpha:Number;
		public var shadowColor:uint;
		public var strength:Number;
		public var type:String;
		public function BevelFilter(distance:Number = 4.0, angle:Number = 45, highlightColor:uint = 0xFFFFFF, highlightAlpha:Number = 1.0, shadowColor:uint = 0x000000, shadowAlpha:Number = 1.0, blurX:Number = 4.0, blurY:Number = 4.0, strength:Number = 1, quality:int = 1, type:String = "inner", knockout:Boolean = false);
		override function clone():BitmapFilter;
	}
}