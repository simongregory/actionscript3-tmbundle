package flash.display {
	import flash.media.SoundTransform;
	public class SimpleButton extends InteractiveObject {
		public function get downState():DisplayObject;
		public function set downState(value:DisplayObject):void;
		public function get enabled():Boolean;
		public function set enabled(value:Boolean):void;
		public function get hitTestState():DisplayObject;
		public function set hitTestState(value:DisplayObject):void;
		public function get overState():DisplayObject;
		public function set overState(value:DisplayObject):void;
		public function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		public function get trackAsMenu():Boolean;
		public function set trackAsMenu(value:Boolean):void;
		public function get upState():DisplayObject;
		public function set upState(value:DisplayObject):void;
		public function get useHandCursor():Boolean;
		public function set useHandCursor(value:Boolean):void;
		public function SimpleButton(upState:DisplayObject = null, overState:DisplayObject = null, downState:DisplayObject = null, hitTestState:DisplayObject = null);
	}
}
