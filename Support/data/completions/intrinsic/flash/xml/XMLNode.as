package flash.xml {
	public class XMLNode {
		public function get attributes():Object;
		public function set attributes(value:Object):void;
		public function get childNodes():Array;
		public var firstChild:XMLNode;
		public var lastChild:XMLNode;
		public function get localName():String;
		public function get namespaceURI():String;
		public var nextSibling:XMLNode;
		public var nodeName:String;
		public var nodeType:uint;
		public var nodeValue:String;
		public var parentNode:XMLNode;
		public function get prefix():String;
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
