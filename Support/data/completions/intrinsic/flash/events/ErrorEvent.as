package flash.events {
	public class ErrorEvent extends TextEvent {
		public function get errorID():int;
		public function ErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0);
		public override function clone():Event;
		public override function toString():String;
		public static const ERROR:String = "error";
	}
}
