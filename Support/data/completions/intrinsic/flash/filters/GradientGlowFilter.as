package flash.filters {
	public final  class GradientGlowFilter extends BitmapFilter {
		public function get alphas():Array;
		public function set alphas(value:Array):void;
		public function get angle():Number;
		public function set angle(value:Number):void;
		public function get blurX():Number;
		public function set blurX(value:Number):void;
		public function get blurY():Number;
		public function set blurY(value:Number):void;
		public function get colors():Array;
		public function set colors(value:Array):void;
		public function get distance():Number;
		public function set distance(value:Number):void;
		public function get knockout():Boolean;
		public function set knockout(value:Boolean):void;
		public function get quality():int;
		public function set quality(value:int):void;
		public function get ratios():Array;
		public function set ratios(value:Array):void;
		public function get strength():Number;
		public function set strength(value:Number):void;
		public function get type():String;
		public function set type(value:String):void;
		public function GradientGlowFilter(distance:Number = 4.0, angle:Number = 45, colors:Array = null, alphas:Array = null, ratios:Array = null, blurX:Number = 4.0, blurY:Number = 4.0, strength:Number = 1, quality:int = 1, type:String = "inner", knockout:Boolean = false);
		public override function clone():BitmapFilter;
	}
}
