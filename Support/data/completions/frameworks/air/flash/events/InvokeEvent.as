package flash.events {
	import flash.filesystem.File;
	public class InvokeEvent extends Event {
		public function get arguments():Array;
		public function get currentDirectory():File;
		public function InvokeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, dir:File = null, argv:Array = null);
		public override function clone():Event;
		public static const INVOKE:String = "invoke";
	}
}
