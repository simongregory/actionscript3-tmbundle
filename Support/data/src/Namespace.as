package
{
	public final class Namespace
	{
		public var prefix:String;
		public var uri:String;
		public function Namespace(uriValue:*);
		public function Namespace(prefixValue:*, uriValue:*);
		public function toString():String;
		public function valueOf():String;
	}
}