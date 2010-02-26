package flash.events {
	import flash.net.NetStream;
	public class DRMAuthenticateEvent extends Event {
		public function get authenticationType():String;
		public function get header():String;
		public function get netstream():NetStream;
		public function get passwordPrompt():String;
		public function get urlPrompt():String;
		public function get usernamePrompt():String;
		public function DRMAuthenticateEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, header:String = "", userPrompt:String = "", passPrompt:String = "", urlPrompt:String = "", authenticationType:String = "", netstream:NetStream = null);
		public override function clone():Event;
		public override function toString():String;
		public static const AUTHENTICATION_TYPE_DRM:String = "drm";
		public static const AUTHENTICATION_TYPE_PROXY:String = "proxy";
		public static const DRM_AUTHENTICATE:String = "drmAuthenticate";
	}
}
