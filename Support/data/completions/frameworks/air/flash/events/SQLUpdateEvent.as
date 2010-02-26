package flash.events {
	public class SQLUpdateEvent extends Event {
		public function get rowID():Number;
		public function get table():String;
		public function SQLUpdateEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, table:String = null, rowID:Number = 0);
		public override function clone():Event;
		public static const DELETE:String = "delete";
		public static const INSERT:String = "insert";
		public static const UPDATE:String = "update";
	}
}
