package flash.filters {
	import flash.display.BitmapData;
	import flash.geom.Point;
	public final  class DisplacementMapFilter extends BitmapFilter {
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		public function get color():uint;
		public function set color(value:uint):void;
		public function get componentX():uint;
		public function set componentX(value:uint):void;
		public function get componentY():uint;
		public function set componentY(value:uint):void;
		public function get mapBitmap():BitmapData;
		public function set mapBitmap(value:BitmapData):void;
		public function get mapPoint():Point;
		public function set mapPoint(value:Point):void;
		public function get mode():String;
		public function set mode(value:String):void;
		public function get scaleX():Number;
		public function set scaleX(value:Number):void;
		public function get scaleY():Number;
		public function set scaleY(value:Number):void;
		public function DisplacementMapFilter(mapBitmap:BitmapData = null, mapPoint:Point = null, componentX:uint = 0, componentY:uint = 0, scaleX:Number = 0.0, scaleY:Number = 0.0, mode:String = "wrap", color:uint = 0, alpha:Number = 0.0);
		public override function clone():BitmapFilter;
	}
}
