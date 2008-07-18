package flash.events {
	public class IOErrorEvent extends ErrorEvent {
		public function IOErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0);
		public override function clone():Event;
		public override function toString():String;
		public static const IO_ERROR:String = "ioError";
	}
}
