package flash.html {
	import flash.geom.Rectangle;
	public class HTMLHost {
		public function get htmlLoader():HTMLLoader;
		public function get windowRect():Rectangle;
		public function set windowRect(value:Rectangle):void;
		public function HTMLHost(defaultBehaviors:Boolean = true);
		public function createWindow(windowCreateOptions:HTMLWindowCreateOptions):HTMLLoader;
		public function updateLocation(locationURL:String):void;
		public function updateStatus(status:String):void;
		public function updateTitle(title:String):void;
		public function windowBlur():void;
		public function windowClose():void;
		public function windowFocus():void;
	}
}
