package flash.events
{
	import flash.events.Event;
	import flash.events.Event;

	public class TextEvent extends Event
	{
		public var text:String;
		public function TextEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "");
		override function clone():Event;
		override function toString():String;
		public static const LINK:String = "link";
		public static const TEXT_INPUT:String = "textInput";
	}
}