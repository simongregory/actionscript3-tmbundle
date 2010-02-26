package flash.events {
	public class DRMStatusEvent extends Event {
		public function get detail():String;
		public function get isAnonymous():Boolean;
		public function get isAvailableOffline():Boolean;
		public function get offlineLeasePeriod():uint;
		public function get policies():Object;
		public function get voucherEndDate():Date;
		public function DRMStatusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, inPolicies:Object = null, inDetail:String = "", inAvailableOffline:Boolean = false, inAnonymous:Boolean = false, inVoucherEndDate:int = 0, inOfflineLeasePeriod:int = 0);
		public override function clone():Event;
		public override function toString():String;
		public static const DRM_STATUS:String = "drmStatus";
	}
}
