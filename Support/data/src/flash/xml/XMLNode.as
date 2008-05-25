package flash.xml
{
	public class XMLNode
	{
		public var attributes:Object;
		public var childNodes:Array;
		public var firstChild:XMLNode;
		public var lastChild:XMLNode;
		public var localName:String;
		public var namespaceURI:String;
		public var nextSibling:XMLNode;
		public var nodeName:String;
		public var nodeType:uint;
		public var nodeValue:String;
		public var parentNode:XMLNode;
		public var prefix:String;
		public var previousSibling:XMLNode;
		public function XMLNode(type:uint, value:String);
		public function appendChild(node:XMLNode):void;
		public function cloneNode(deep:Boolean):XMLNode;
		public function getNamespaceForPrefix(prefix:String):String;
		public function getPrefixForNamespace(ns:String):String;
		public function hasChildNodes():Boolean;
		public function insertBefore(node:XMLNode, before:XMLNode):void;
		public function removeNode():void;
		public function toString():String;
	}
}