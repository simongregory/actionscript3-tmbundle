package flash.errors {
	public class SQLError extends Error {
		public function get details():String;
		public function get operation():String;
		public function SQLError(operation:String, details:String = "", message:String = "", id:int = 0);
		public function toString():String;
	}
}
