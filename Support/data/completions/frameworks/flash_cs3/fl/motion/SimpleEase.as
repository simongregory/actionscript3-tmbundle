package fl.motion
{
public class SimpleEase implements ITween
{
		private var _ease : Number;
		private var _target : String;
		public function get ease () : Number;
		public function set ease (value:Number) : Void;
		public function get target () : String;
		public function set target (value:String) : Void;
		internal function SimpleEase (xml:XML =null);
		private function parseXML (xml:XML =null) : SimpleEase;
		public static function easeQuadPercent (time:Number, begin:Number, change:Number, duration:Number, percent:Number) : Number;
		public static function easeNone (time:Number, begin:Number, change:Number, duration:Number) : Number;
		public function getValue (time:Number, begin:Number, change:Number, duration:Number) : Number;
}
}
