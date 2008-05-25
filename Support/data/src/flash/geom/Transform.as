package flash.geom
{
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class Transform
	{
		public var colorTransform:ColorTransform;
		public var concatenatedColorTransform:ColorTransform;
		public var concatenatedMatrix:Matrix;
		public var matrix:Matrix;
		public var pixelBounds:Rectangle;
	}
}