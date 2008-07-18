package flash.display {
	import flash.geom.Matrix;
	public final  class Graphics {
		public function beginBitmapFill(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):void;
		public function beginFill(color:uint, alpha:Number = 1.0):void;
		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void;
		public function clear():void;
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void;
		public function drawCircle(x:Number, y:Number, radius:Number):void;
		public function drawEllipse(x:Number, y:Number, width:Number, height:Number):void;
		public function drawRect(x:Number, y:Number, width:Number, height:Number):void;
		public function drawRoundRect(x:Number, y:Number, width:Number, height:Number, ellipseWidth:Number, ellipseHeight:Number = NaN):void;
		public function drawRoundRectComplex(x:Number, y:Number, width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number):void; 
		public function endFill():void;
		public function lineGradientStyle(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void;
		public function lineStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void;
		public function lineTo(x:Number, y:Number):void;
		public function moveTo(x:Number, y:Number):void;
	}
}
