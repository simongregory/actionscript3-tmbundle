package
{
	public dynamic class Error
	{
		public var errorID:int;
		public var message:String;
		public var name:String;
		public function Error(message:String = "", id:int = 0);
		public function getStackTrace():String;
		override function toString():String;
	}
}