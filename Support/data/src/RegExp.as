package
{
	public dynamic class RegExp
	{
		public var dotall:Boolean;
		public var extended:Boolean;
		public var global:Boolean;
		public var ignoreCase:Boolean;
		public var lastIndex:Number;
		public var multiline:Boolean;
		public var source:String;
		public function RegExp(re:String, flags:String);
		public function exec(str:String):Object;
		public function test(str:String):Boolean;
	}
}