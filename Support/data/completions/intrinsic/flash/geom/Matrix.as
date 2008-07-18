package flash.geom {
	public class Matrix {
		public var a:Number;
		public var b:Number;
		public var c:Number;
		public var d:Number;
		public var tx:Number;
		public var ty:Number;
		public function Matrix(a:Number = 1, b:Number = 0, c:Number = 0, d:Number = 1, tx:Number = 0, ty:Number = 0);
		public function clone():Matrix;
		public function concat(m:Matrix):void;
		public function createBox(scaleX:Number, scaleY:Number, rotation:Number = 0, tx:Number = 0, ty:Number = 0):void;
		public function createGradientBox(width:Number, height:Number, rotation:Number = 0, tx:Number = 0, ty:Number = 0):void;
		public function deltaTransformPoint(point:Point):Point;
		public function identity():void;
		public function invert():void;
		public function rotate(angle:Number):void;
		public function scale(sx:Number, sy:Number):void;
		public function toString():String;
		public function transformPoint(point:Point):Point;
		public function translate(dx:Number, dy:Number):void;
	}
}
