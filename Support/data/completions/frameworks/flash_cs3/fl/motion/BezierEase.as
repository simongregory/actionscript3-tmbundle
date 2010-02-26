package fl.motion
{
import flash.geom.Point;
public class BezierEase implements ITween
{
		public var points : Array;
		private var firstNode : Point;
		private var lastNode : Point;
		private var _target : String;
		public function get target () : String;
		public function set target (value:String) : Void;
		internal function BezierEase (xml:XML =null);
		private function parseXML (xml:XML =null) : BezierEase;
		public function getValue (time:Number, begin:Number, change:Number, duration:Number) : Number;
}
}
