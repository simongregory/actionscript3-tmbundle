package flash.events
{
	import flash.events.Event;
	import flash.events.Event;

	public class SyncEvent extends Event
	{
		public var changeList:Array;
		public function SyncEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, changeList:Array = null);
		override function clone():Event;
		override function toString():String;
		public static const SYNC:String = "sync";
	}
}