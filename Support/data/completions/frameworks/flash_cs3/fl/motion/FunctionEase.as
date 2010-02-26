package fl.motion
{
import flash.utils.*;
public class FunctionEase implements ITween
{
		private var _functionName : String;
		public var easingFunction : Function;
		public var parameters : Array;
		private var _target : String;
		public function get functionName () : String;
		public function set functionName (newName:String) : Void;
		public function get target () : String;
		public function set target (value:String) : Void;
		internal function FunctionEase (xml:XML =null);
		private function parseXML (xml:XML =null) : FunctionEase;
		public function getValue (time:Number, begin:Number, change:Number, duration:Number) : Number;
}
}
