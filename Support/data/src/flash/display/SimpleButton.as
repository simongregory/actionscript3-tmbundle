package flash.display
{
	import flash.display.DisplayObject;
	import flash.media.SoundTransform;
	import flash.display.InteractiveObject;

	public class SimpleButton extends InteractiveObject
	{
		public var downState:DisplayObject;
		public var enabled:Boolean;
		public var hitTestState:DisplayObject;
		public var overState:DisplayObject;
		public var soundTransform:SoundTransform;
		public var trackAsMenu:Boolean;
		public var upState:DisplayObject;
		public var useHandCursor:Boolean;
		public function SimpleButton(upState:DisplayObject = null, overState:DisplayObject = null, downState:DisplayObject = null, hitTestState:DisplayObject = null);
	}
}