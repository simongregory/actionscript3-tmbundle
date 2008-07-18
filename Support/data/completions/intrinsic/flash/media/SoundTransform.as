package flash.media {
	public final  class SoundTransform {
		public function get leftToLeft():Number;
		public function set leftToLeft(value:Number):void;
		public function get leftToRight():Number;
		public function set leftToRight(value:Number):void;
		public function get pan():Number;
		public function set pan(value:Number):void;
		public function get rightToLeft():Number;
		public function set rightToLeft(value:Number):void;
		public function get rightToRight():Number;
		public function set rightToRight(value:Number):void;
		public function get volume():Number;
		public function set volume(value:Number):void;
		public function SoundTransform(vol:Number = 1, panning:Number = 0);
	}
}
