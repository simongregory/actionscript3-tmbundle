package fl.motion
{
import fl.motion.*;
import flash.display.*;
import flash.geom.ColorTransform;
public class Color extends ColorTransform
{
		private var _tintColor : Number;
		private var _tintMultiplier : Number;
		public function get brightness () : Number;
		public function set brightness (value:Number) : Void;
		public function get tintColor () : uint;
		public function set tintColor (value:uint) : Void;
		public function get tintMultiplier () : Number;
		public function set tintMultiplier (value:Number) : Void;
		internal function Color (redMultiplier:Number =1.0, greenMultiplier:Number =1.0, blueMultiplier:Number =1.0, alphaMultiplier:Number =1.0, redOffset:Number =0, greenOffset:Number =0, blueOffset:Number =0, alphaOffset:Number =0);
		public function setTint (tintColor:uint, tintMultiplier:Number) : void;
		private function deriveTintColor () : uint;
		public static function fromXML (xml:XML) : Color;
		private function parseXML (xml:XML =null) : Color;
		public static function interpolateTransform (fromColor:ColorTransform, toColor:ColorTransform, progress:Number) : ColorTransform;
		public static function interpolateColor (fromColor:uint, toColor:uint, progress:Number) : uint;
}
}
