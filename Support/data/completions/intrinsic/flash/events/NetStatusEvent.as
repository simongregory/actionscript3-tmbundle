package flash.events {
	public class NetStatusEvent extends Event {
		public function get info():Object;
		public function set info(value:Object):void;
		public function NetStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, info:Object = null);
		public override function clone():Event;
		public override function toString():String;
		public static const NET_STATUS:String = "netStatus";
	}
}
