package flash.display
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	public class Bitmap extends DisplayObject
	{
		public var bitmapData:BitmapData;
		public var pixelSnapping:String;
		public var smoothing:Boolean;
		public function Bitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false);
	}
}