package fl.motion
{
import flash.geom.*;
public class MatrixTransformer
{
		public static function getScaleX (m:Matrix) : Number;
		public static function setScaleX (m:Matrix, scaleX:Number) : void;
		public static function getScaleY (m:Matrix) : Number;
		public static function setScaleY (m:Matrix, scaleY:Number) : void;
		public static function getSkewXRadians (m:Matrix) : Number;
		public static function setSkewXRadians (m:Matrix, skewX:Number) : void;
		public static function getSkewYRadians (m:Matrix) : Number;
		public static function setSkewYRadians (m:Matrix, skewY:Number) : void;
		public static function getSkewX (m:Matrix) : Number;
		public static function setSkewX (m:Matrix, skewX:Number) : void;
		public static function getSkewY (m:Matrix) : Number;
		public static function setSkewY (m:Matrix, skewY:Number) : void;
		public static function getRotationRadians (m:Matrix) : Number;
		public static function setRotationRadians (m:Matrix, rotation:Number) : void;
		public static function getRotation (m:Matrix) : Number;
		public static function setRotation (m:Matrix, rotation:Number) : void;
		public static function rotateAroundInternalPoint (m:Matrix, x:Number, y:Number, angleDegrees:Number) : void;
		public static function rotateAroundExternalPoint (m:Matrix, x:Number, y:Number, angleDegrees:Number) : void;
		public static function matchInternalPointWithExternal (m:Matrix, internalPoint:Point, externalPoint:Point) : void;
}
}
