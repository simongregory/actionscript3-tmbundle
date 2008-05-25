package flash.events
{
	import flash.events.Event;
	import flash.events.ErrorEvent;

	public class SecurityErrorEvent extends ErrorEvent
	{
		public function SecurityErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "");
		override function clone():Event;
		override function toString():String;
		public static const SECURITY_ERROR:String = "securityError";
	}
}