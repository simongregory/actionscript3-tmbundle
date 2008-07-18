package flash.events {
	public class StatusEvent extends Event {
		public function get code():String;
		public function set code(value:String):void;
		public function get level():String;
		public function set level(value:String):void;
		public function StatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, code:String = "", level:String = "");
		public override function clone():Event;
		public override function toString():String;
		public static const STATUS:String = "status";
	}
}
