package flash.events {
	public class HTMLUncaughtScriptExceptionEvent extends Event {
		public var exceptionValue:*;
		public var stackTrace:Array;
		public function HTMLUncaughtScriptExceptionEvent(exceptionValue:*);
		public override function clone():Event;
		public static const UNCAUGHT_SCRIPT_EXCEPTION:* = uncaughtScriptException;
	}
}
