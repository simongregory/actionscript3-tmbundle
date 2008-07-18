package {
	public dynamic  class RegExp {
		public function get dotall():Boolean;
		public function get extended():Boolean;
		public function get global():Boolean;
		public function get ignoreCase():Boolean;
		public function get lastIndex():Number;
		public function set lastIndex(value:Number):void;
		public function get multiline():Boolean;
		public function get source():String;
		public function RegExp(re:String, flags:String);
		public function exec(str:String):Object;
		public function test(str:String):Boolean;
	}
}
