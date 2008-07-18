package flash.filters {
	public final  class GlowFilter extends BitmapFilter {
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		public function get blurX():Number;
		public function set blurX(value:Number):void;
		public function get blurY():Number;
		public function set blurY(value:Number):void;
		public function get color():uint;
		public function set color(value:uint):void;
		public function get inner():Boolean;
		public function set inner(value:Boolean):void;
		public function get knockout():Boolean;
		public function set knockout(value:Boolean):void;
		public function get quality():int;
		public function set quality(value:int):void;
		public function get strength():Number;
		public function set strength(value:Number):void;
		public function GlowFilter(color:uint = 0xFF0000, alpha:Number = 1.0, blurX:Number = 6.0, blurY:Number = 6.0, strength:Number = 2, quality:int = 1, inner:Boolean = false, knockout:Boolean = false);
		public override function clone():BitmapFilter;
	}
}
