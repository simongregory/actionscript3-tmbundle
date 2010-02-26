package flash.events {
	public class OutputProgressEvent extends Event {
		public function get bytesPending():Number;
		public function set bytesPending(value:Number):void;
		public function get bytesTotal():Number;
		public function set bytesTotal(value:Number):void;
		public function OutputProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesPending:Number = 0, bytesTotal:Number = 0);
		public override function clone():Event;
		public override function toString():String;
		public static const OUTPUT_PROGRESS:String = "outputProgress";
	}
}
