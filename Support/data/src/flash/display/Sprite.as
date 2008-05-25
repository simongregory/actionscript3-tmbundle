package flash.display
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.media.SoundTransform;
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;

	public class Sprite extends DisplayObjectContainer
	{
		public var buttonMode:Boolean;
		public var dropTarget:DisplayObject;
		public var graphics:Graphics;
		public var hitArea:Sprite;
		public var soundTransform:SoundTransform;
		public var useHandCursor:Boolean;
		public function Sprite();
		public function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void;
		public function stopDrag():void;
	}
}