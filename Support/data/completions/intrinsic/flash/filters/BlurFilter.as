package flash.filters {
	public final class BlurFilter extends BitmapFilter {
		public function get blurX():Number;
		public function set blurX(value:Number):void;
		public function get blurY():Number;
		public function set blurY(value:Number):void;
		public function get quality():int;
		public function set quality(value:int):void;
		public function BlurFilter(blurX:Number = 4.0, blurY:Number = 4.0, quality:int = 1);
		public override function clone():BitmapFilter;
	}
}
