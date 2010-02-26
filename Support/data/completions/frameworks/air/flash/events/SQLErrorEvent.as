package flash.events {
	import flash.errors.SQLError;
	public class SQLErrorEvent extends ErrorEvent {
		public function get error():SQLError;
		public function SQLErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, error:SQLError = null);
		public override function clone():Event;
		public override function toString():String;
		public static const ERROR:String = "error";
	}
}
