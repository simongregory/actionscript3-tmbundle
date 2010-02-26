package fl.motion
{
import flash.geom.ColorTransform;
import flash.utils.*;
import flash.filters.*;
import flash.utils.getQualifiedClassName;
public class Motion
{
		public var source : Source;
		public var keyframes : Array;
		private var _keyframesCompact : Array;
		private var _duration : int;
		private static var typeCache : Object;
		public function get keyframesCompact () : Array;
		public function set keyframesCompact (compactArray:Array) : Void;
		public function get duration () : int;
		public function set duration (value:int) : Void;
		internal function Motion (xml:XML =null);
		private function indexOutOfRange (index:int) : Boolean;
		public function getCurrentKeyframe (index:int, tweenableName:String ='') : Keyframe;
		public function getNextKeyframe (index:int, tweenableName:String ='') : Keyframe;
		public function setValue (index:int, tweenableName:String, value:Number) : void;
		public function getColorTransform (index:int) : ColorTransform;
		public function getFilters (index:Number) : Array;
		public function getValue (index:Number, tweenableName:String) : Number;
		public function addKeyframe (newKeyframe:Keyframe) : void;
		private function parseXML (xml:XML) : Motion;
		public static function fromXMLString (xmlString:String) : Motion;
		public static function interpolateFilters (fromFilters:Array, toFilters:Array, progress:Number) : Array;
		public static function interpolateFilter (fromFilter:BitmapFilter, toFilter:BitmapFilter, progress:Number) : BitmapFilter;
		private static function getTypeInfo (o:*) : XML;
}
}
