package fl.motion
{
import fl.motion.*;
import flash.geom.Point;
import flash.geom.Rectangle;
public class Source
{
		public var frameRate : Number;
		public var elementType : String;
		public var symbolName : String;
		public var instanceName : String;
		public var linkageID : String;
		public var x : Number;
		public var y : Number;
		public var scaleX : Number;
		public var scaleY : Number;
		public var skewX : Number;
		public var skewY : Number;
		public var rotation : Number;
		public var transformationPoint : Point;
		public var dimensions : Rectangle;
		internal function Source (xml:XML =null);
		private function parseXML (xml:XML =null) : Source;
}
}
