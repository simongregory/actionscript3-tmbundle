package flash.events {
	public class ProgressEvent extends Event {
		public function get bytesLoaded():Number;
		public function set bytesLoaded(value:Number):void;
		public function get bytesTotal():Number;
		public function set bytesTotal(value:Number):void;
		public function ProgressEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, bytesLoaded:Number = 0, bytesTotal:Number = 0);
		public override function clone():Event;
		public override function toString():String;
		public static const PROGRESS:String = "progress";
		public static const SOCKET_DATA:String = "socketData";
	}
}
