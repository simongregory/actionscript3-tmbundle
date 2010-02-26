package flash.events {
	public class DRMErrorEvent extends ErrorEvent {
		public function get subErrorID():int;
		public function DRMErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inErrorDetail:String = "", inErrorCode:int = 0, insubErrorID:int = 0);
		public override function clone():Event;
		public override function toString():String;
		public static const DRM_ERROR:String = "drmError";
	}
}
