package flash.filters {
	public final  class BevelFilter extends BitmapFilter {
		public function get angle():Number;
		public function set angle(value:Number):void;
		public function get blurX():Number;
		public function set blurX(value:Number):void;
		public function get blurY():Number;
		public function set blurY(value:Number):void;
		public function get distance():Number;
		public function set distance(value:Number):void;
		public function get highlightAlpha():Number;
		public function set highlightAlpha(value:Number):void;
		public function get highlightColor():uint;
		public function set highlightColor(value:uint):void;
		public function get knockout():Boolean;
		public function set knockout(value:Boolean):void;
		public function get quality():int;
		public function set quality(value:int):void;
		public function get shadowAlpha():Number;
		public function set shadowAlpha(value:Number):void;
		public function get shadowColor():uint;
		public function set shadowColor(value:uint):void;
		public function get strength():Number;
		public function set strength(value:Number):void;
		public function get type():String;
		public function set type(value:String):void;
		public function BevelFilter(distance:Number = 4.0, angle:Number = 45, highlightColor:uint = 0xFFFFFF, highlightAlpha:Number = 1.0, shadowColor:uint = 0x000000, shadowAlpha:Number = 1.0, blurX:Number = 4.0, blurY:Number = 4.0, strength:Number = 1, quality:int = 1, type:String = "inner", knockout:Boolean = false);
		public override function clone():BitmapFilter;
	}
}
