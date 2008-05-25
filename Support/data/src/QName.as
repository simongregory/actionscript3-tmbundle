package
{
	public final class QName
	{
		public var localName:String;
		public var uri:String;
		public function QName(qname:QName);
		public function QName(uri:Namespace, localName:QName);
		public function toString():String;
		public function valueOf():QName;
	}
}