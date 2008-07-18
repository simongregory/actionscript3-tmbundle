package flash.filters {
	public final  class DropShadowFilter extends BitmapFilter {
		public function get alpha():Number;
		public function set alpha(value:Number):void;
		public function get angle():Number;
		public function set angle(value:Number):void;
		public function get blurX():Number;
		public function set blurX(value:Number):void;
		public function get blurY():Number;
		public function set blurY(value:Number):void;
		public function get color():uint;
		public function set color(value:uint):void;
		public function get distance():Number;
		public function set distance(value:Number):void;
		public function get hideObject():Boolean;
		public function set hideObject(value:Boolean):void;
		public function get inner():Boolean;
		public function set inner(value:Boolean):void;
		public function get knockout():Boolean;
		public function set knockout(value:Boolean):void;
		public function get quality():int;
		public function set quality(value:int):void;
		public function get strength():Number;
		public function set strength(value:Number):void;
		public function DropShadowFilter(distance:Number = 4.0, angle:Number = 45, color:uint = 0, alpha:Number = 1.0, blurX:Number = 4.0, blurY:Number = 4.0, strength:Number = 1.0, quality:int = 1, inner:Boolean = false, knockout:Boolean = false, hideObject:Boolean = false);
		public override function clone():BitmapFilter;
	}
}
