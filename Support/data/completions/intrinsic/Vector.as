package
{
	public class Vector.<T> extends Object
	{
		public function set length (value:uint) : Void;
		public function get length () : uint;
		public function set fixed (f:Boolean) : Void;
		public function get fixed () : Boolean;
		public function shift () : T;
		public function reverse () : Vector.<T>;
		public function unshift () : uint;
		public function indexOf (value:Number = null, from:Number = 0) : Number;
		public function pop () : T;
		public function slice (start:Number = 0, end:Number = 2147483647) : Vector.<T>;
		public function concat () : Vector.<T>;
		public function some (checker:* = null, thisObj:Object = null) : Boolean;
		public function push () : uint;
		public function every (checker:Function = null, thisObj:Object = null) : Boolean;
		public function map (mapper:Function = null, thisObj:Object = null) : *;
		public function sort (comparefn:*) : Vector.<T>;
		public function forEach (eacher:Function = null, thisObj:Object = null) : void;
		public function lastIndexOf (value:Number = null, from:Number = 2147483647) : Number;
		public function toString () : String;
		public function toLocaleString () : String;
		public function join (separator:String = ",") : String;
		public function filter (checker:Function = null, thisObj:Object = null) : Vector.<T>;
		public function splice (start:Number, deleteCount:Number) : Vector.<T>;
		public function Vector (length:uint = 0, fixed:Boolean = false);
	}
}
