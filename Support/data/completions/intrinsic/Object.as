package {
	public dynamic class Object {
		public var constructor:Object;
		public static var prototype:Object;
		public function Object();
		public function hasOwnProperty(name:String):Boolean;
		public function isPrototypeOf(theClass:Object):Boolean;
		public function propertyIsEnumerable(name:String):Boolean;
		public function setPropertyIsEnumerable(name:String, isEnum:Boolean = true):void;
		public function toString():String;
		public function valueOf():Object;
	}
}
