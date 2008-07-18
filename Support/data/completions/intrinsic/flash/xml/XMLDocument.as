package flash.xml {
	public class XMLDocument extends XMLNode {
		public var docTypeDecl:Object = null;
		public var idMap:Object;
		public var ignoreWhite:Boolean = false;
		public var xmlDecl:Object = null;
		public function XMLDocument(source:String = null);
		public function createElement(name:String):XMLNode;
		public function createTextNode(text:String):XMLNode;
		public function parseXML(source:String):void;
		public override function toString():String;
	}
}
