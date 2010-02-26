package fl.motion
{
import flash.utils.*;
import flash.geom.ColorTransform;
import flash.filters.BitmapFilter;
import flash.display.BlendMode;
public class Keyframe
{
		private var _index : int;
		public var x : Number;
		public var y : Number;
		public var scaleX : Number;
		public var scaleY : Number;
		public var skewX : Number;
		public var skewY : Number;
		public var tweens : Array;
		public var filters : Array;
		public var color : fl.motion.Color;
		public var label : String;
		public var tweenScale : Boolean;
		public var tweenSnap : Boolean;
		public var tweenSync : Boolean;
		public var loop : String;
		public var firstFrame : String;
		public var cacheAsBitmap : Boolean;
		public var blendMode : String;
		public var rotateDirection : String;
		public var rotateTimes : uint;
		public var orientToPath : Boolean;
		public var blank : Boolean;
		public function get index () : int;
		public function set index (value:int) : Void;
		public function get rotation () : Number;
		public function set rotation (value:Number) : Void;
		internal function Keyframe (xml:XML =null);
		private function setDefaults () : void;
		public function getValue (tweenableName:String) : Number;
		public function setValue (tweenableName:String, newValue:Number) : void;
		private function parseXML (xml:XML =null) : Keyframe;
		private static function splitNumber (valuesString:String) : Array;
		private static function splitUint (valuesString:String) : Array;
		private static function splitInt (valuesString:String) : Array;
		public function getTween (target:String ='') : ITween;
		public function affectsTweenable (tweenableName:String ='') : Boolean;
}
}
