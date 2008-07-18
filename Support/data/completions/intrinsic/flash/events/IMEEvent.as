package flash.events {
	public class IMEEvent extends TextEvent {
		public function IMEEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "");
		public override function clone():Event;
		public override function toString():String;
		public static const IME_COMPOSITION:String = "imeComposition";
	}
}
