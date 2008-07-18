package {
	public final  class Namespace {
		public function get prefix():String;
		public function set prefix(value:String):void;
		public function get uri():String;
		public function set uri(value:String):void;
		public function Namespace(uriValue:*);
		public function Namespace(prefixValue:*, uriValue:*);
		public function toString():String;
		public function valueOf():String;
	}
}
