package flash.events {
	public class SQLEvent extends Event {
		public function SQLEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false);
		public override function clone():Event;
		public static const ANALYZE:String = "analyze";
		public static const ATTACH:String = "attach";
		public static const BEGIN:String = "begin";
		public static const CANCEL:String = "cancel";
		public static const CLOSE:String = "close";
		public static const COMMIT:String = "commit";
		public static const COMPACT:String = "compact";
		public static const DEANALYZE:String = "deanalyze";
		public static const DETACH:String = "detach";
		public static const OPEN:String = "open";
		public static const RESULT:String = "result";
		public static const ROLLBACK:String = "rollback";
		public static const SCHEMA:String = "schema";
	}
}
