package fl.motion
{
import flash.geom.Point;
public class CustomEase implements ITween
{
		public var points : Array;
		private var firstNode : Point;
		private var lastNode : Point;
		private var _target : String;
		public function get target () : String;
		public function set target (value:String) : Void;
		internal function CustomEase (xml:XML =null);
		private function parseXML (xml:XML =null) : CustomEase;
		public function getValue (time:Number, begin:Number, change:Number, duration:Number) : Number;
		internal static function getYForPercent (percent:Number, pts:Array) : Number;
}
}
