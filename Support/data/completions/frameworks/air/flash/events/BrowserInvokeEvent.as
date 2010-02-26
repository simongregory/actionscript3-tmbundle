package flash.events {
	public class BrowserInvokeEvent extends Event {
		public function get arguments():Array;
		public function get isHTTPS():Boolean;
		public function get isUserEvent():Boolean;
		public function get sandboxType():String;
		public function get securityDomain():String;
		public function BrowserInvokeEvent(type:String, bubbles:Boolean, cancelable:Boolean, arguments:Array, sandboxType:String, securityDomain:String, isHTTPS:Boolean, isUserEvent:Boolean);
		public override function clone():Event;
		public static const BROWSER_INVOKE:String = "browserInvoke";
	}
}
