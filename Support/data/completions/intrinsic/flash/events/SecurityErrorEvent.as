package flash.events {
	public class SecurityErrorEvent extends ErrorEvent {
		public function SecurityErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "", id:int = 0);
		public override function clone():Event;
		public override function toString():String;
		public static const SECURITY_ERROR:String = "securityError";
	}
}
