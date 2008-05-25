package flash.geom
{
	import flash.geom.Point;

	public class Rectangle
	{
		public var bottom:Number;
		public var bottomRight:Point;
		public var height:Number;
		public var left:Number;
		public var right:Number;
		public var size:Point;
		public var top:Number;
		public var topLeft:Point;
		public var width:Number;
		public var x:Number;
		public var y:Number;
		public function Rectangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0);
		public function clone():Rectangle;
		public function contains(x:Number, y:Number):Boolean;
		public function containsPoint(point:Point):Boolean;
		public function containsRect(rect:Rectangle):Boolean;
		public function equals(toCompare:Rectangle):Boolean;
		public function inflate(dx:Number, dy:Number):void;
		public function inflatePoint(point:Point):void;
		public function intersection(toIntersect:Rectangle):Rectangle;
		public function intersects(toIntersect:Rectangle):Boolean;
		public function isEmpty():Boolean;
		public function offset(dx:Number, dy:Number):void;
		public function offsetPoint(point:Point):void;
		public function setEmpty():void;
		public function toString():String;
		public function union(toUnion:Rectangle):Rectangle;
	}
}