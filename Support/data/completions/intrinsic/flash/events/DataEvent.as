package flash.events {
	public class DataEvent extends TextEvent {
		public function get data():String;
		public function set data(value:String):void;
		public function DataEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:String = "");
		public override function clone():Event;
		public override function toString():String;
		public static const DATA:String = "data";
		public static const UPLOAD_COMPLETE_DATA:String = "uploadCompleteData";
	}
}
