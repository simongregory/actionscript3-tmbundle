package {
	public dynamic  class Array {
		public function get length():uint;
		public function set length(value:uint):void;
		public function Array(numElements:int = 0);
		public function Array(... values);
		public function concat(... args):Array;
		public function every(callback:Function, thisObject:* = null):Boolean;
		public function filter(callback:Function, thisObject:* = null):Array;
		public function forEach(callback:Function, thisObject:* = null):void;
		public function indexOf(searchElement:*, fromIndex:int = 0):int;
		public function join(sep:*):String;
		public function lastIndexOf(searchElement:*, fromIndex:int = 0x7fffffff):int;
		public function map(callback:Function, thisObject:* = null):Array;
		public function pop():*;
		public function push(... args):uint;
		public function reverse():Array;
		public function shift():*;
		public function slice(startIndex:int = 0, endIndex:int = 16777215):Array;
		public function some(callback:Function, thisObject:* = null):Boolean;
		public function sort(... args):Array;
		public function sortOn(fieldName:Object, options:Object = null):Array;
		public function splice(startIndex:int, deleteCount:uint, ... values):Array;
		public function toLocaleString():String;
		public function toString():String;
		public function unshift(... args):uint;
		public static const CASEINSENSITIVE:uint = 1;
		public static const DESCENDING:uint = 2;
		public static const NUMERIC:uint = 16;
		public static const RETURNINDEXEDARRAY:uint = 8;
		public static const UNIQUESORT:uint = 4;
	}
}
