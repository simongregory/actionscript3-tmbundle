package flash.filters {
	public final  class ColorMatrixFilter extends BitmapFilter {
		public function get matrix():Array;
		public function set matrix(value:Array):void;
		public function ColorMatrixFilter(matrix:Array = null);
		public override function clone():BitmapFilter;
	}
}
