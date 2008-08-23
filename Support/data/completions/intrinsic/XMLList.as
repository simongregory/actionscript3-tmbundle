package {
public final dynamic class XMLList {
	public function XMLList(value:Object);
	public function attribute(attributeName:*):XMLList;
	public function attributes():XMLList;
	public function child(propertyName:Object):XMLList;
	public function children():XMLList;
	public function comments():XMLList;
	public function contains(value:XML):Boolean;
	public function copy():XMLList;
	public function descendants(name:Object = *):XMLList;
	public function elements(name:Object = *):XMLList;
	public function hasComplexContent():Boolean;
	public function hasOwnProperty(p:String):Boolean;
	public function hasSimpleContent():Boolean;
	public function length():int;
	public function normalize():XMLList;
	public function parent():Object;
	public function processingInstructions(name:String = "*"):XMLList;
	public function propertyIsEnumerable(p:String):Boolean;
	public function text():XMLList;
	public function toString():String;
	public function toXMLString():String;
	public function valueOf():XMLList;
}
}
