package flash.events {
	public class SyncEvent extends Event {
		public function get changeList():Array;
		public function set changeList(value:Array):void;
		public function SyncEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, changeList:Array = null);
		public override function clone():Event;
		public override function toString():String;
		public static const SYNC:String = "sync";
	}
}
