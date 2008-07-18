package {
	public final  class Number {
		public function Number(num:Object);
		public function toExponential(fractionDigits:uint):String;
		public function toFixed(fractionDigits:uint):String;
		public function toPrecision(precision:uint):String;
		public function toString(radix:Number = 10):String;
		public function valueOf():Number;
		public static const MAX_VALUE:Number;
		public static const MIN_VALUE:Number;
		public static const NaN:Number;
		public static const NEGATIVE_INFINITY:Number;
		public static const POSITIVE_INFINITY:Number;
	}
}
