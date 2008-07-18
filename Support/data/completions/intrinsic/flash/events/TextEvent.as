package flash.events {
	public class TextEvent extends Event {
		public function get text():String;
		public function set text(value:String):void;
		public function TextEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "");
		public override function clone():Event;
		public override function toString():String;
		public static const LINK:String = "link";
		public static const TEXT_INPUT:String = "textInput";
	}
}
