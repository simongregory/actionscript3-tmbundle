package flash.events
{
	import flash.events.Event;
	import flash.events.Event;

	public class NetStatusEvent extends Event
	{
		public var info:Object;
		public function NetStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, info:Object = null);
		override function clone():Event;
		override function toString():String;
		public static const NET_STATUS:String = "netStatus";
	}
}