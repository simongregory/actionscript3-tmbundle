package flash.display {
	import flash.media.SoundTransform;
	import flash.geom.Rectangle;
	public class Sprite extends DisplayObjectContainer {
		public function get buttonMode():Boolean;
		public function set buttonMode(value:Boolean):void;
		public function get dropTarget():DisplayObject;
		public function get graphics():Graphics;
		public function get hitArea():Sprite;
		public function set hitArea(value:Sprite):void;
		public function get soundTransform():SoundTransform;
		public function set soundTransform(value:SoundTransform):void;
		public function get useHandCursor():Boolean;
		public function set useHandCursor(value:Boolean):void;
		public function Sprite();
		public function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void;
		public function stopDrag():void;
	}
}
