package
{
	public final dynamic class XML
	{
		public var ignoreComments:Boolean;
		public var ignoreProcessingInstructions:Boolean;
		public var ignoreWhitespace:Boolean;
		public var prettyIndent:int;
		public var prettyPrinting:Boolean;
		public function XML(value:Object);
		public function addNamespace(ns:Object):XML;
		public function appendChild(child:Object):XML;
		public function attribute(attributeName:*):XMLList;
		public function attributes():XMLList;
		public function child(propertyName:Object):XMLList;
		public function childIndex():int;
		public function children():XMLList;
		public function comments():XMLList;
		public function contains(value:XML):Boolean;
		public function copy():XML;
		public static function defaultSettings():Object;
		public function descendants(name:Object = *):XMLList;
		public function elements(name:Object = *):XMLList;
		public function hasComplexContent():Boolean;
		public function hasOwnProperty(p:String):Boolean;
		public function hasSimpleContent():Boolean;
		public function inScopeNamespaces():Array;
		public function insertChildAfter(child1:Object, child2:Object):*;
		public function insertChildBefore(child1:Object, child2:Object):*;
		public function length():int;
		public function localName():Object;
		public function name():Object;
		public function namespace(prefix:String = null):*;
		public function namespaceDeclarations():Array;
		public function nodeKind():String;
		public function normalize():XML;
		public function parent():*;
		public function prependChild(value:Object):XML;
		public function processingInstructions(name:String = "*"):XMLList;
		public function propertyIsEnumerable(p:String):Boolean;
		public function removeNamespace(ns:Namespace):XML;
		public function replace(propertyName:Object, value:XML):XML;
		public function setChildren(value:Object):XML;
		public function setLocalName(name:String):void;
		public function setName(name:String):void;
		public function setNamespace(ns:Namespace):void;
		public static function setSettings(... rest):void;
		public static function settings():Object;
		public function text():XMLList;
		public function toString():String;
		public function toXMLString():String;
		public function valueOf():XML;
	}
}