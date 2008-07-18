package flash.net {
	public final  class FileFilter {
		public function get description():String;
		public function set description(value:String):void;
		public function get extension():String;
		public function set extension(value:String):void;
		public function get macType():String;
		public function set macType(value:String):void;
		public function FileFilter(description:String, extension:String, macType:String = null);
	}
}
