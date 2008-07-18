package {
	public dynamic  class Error {
		public function get errorID():int;
		public var message:String;
		public var name:String;
		public function Error(message:String = "", id:int = 0);
		public function getStackTrace():String;
		public override function toString():String;
	}
}
