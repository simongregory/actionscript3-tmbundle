package flash.events
{
	import flash.events.Event;
	import flash.events.TextEvent;

	public class IMEEvent extends TextEvent
	{
		public function IMEEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "");
		override function clone():Event;
		override function toString():String;
		public static const IME_COMPOSITION:String = "imeComposition";
	}
}