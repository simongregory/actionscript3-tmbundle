package fl.motion
{
import flash.geom.Point;
public class BezierSegment
{
		public var a : Point;
		public var b : Point;
		public var c : Point;
		public var d : Point;
		internal function BezierSegment (a:Point, b:Point, c:Point, d:Point);
		public function getValue (t:Number) : Point;
		public static function getSingleValue (t:Number, a:Number =0, b:Number =0, c:Number =0, d:Number =0) : Number;
		public function getYForX (x:Number, coefficients:Array =null) : Number;
		public static function getCubicCoefficients (a:Number, b:Number, c:Number, d:Number) : Array;
		public static function getCubicRoots (a:Number =0, b:Number =0, c:Number =0, d:Number =0) : Array;
		public static function getQuadraticRoots (a:Number, b:Number, c:Number) : Array;
}
}
