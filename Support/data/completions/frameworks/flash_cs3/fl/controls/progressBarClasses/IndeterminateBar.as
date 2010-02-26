package fl.controls.progressBarClasses
{
import fl.controls.ProgressBar;
import fl.core.UIComponent;
import fl.core.InvalidationType;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.events.Event;
public class IndeterminateBar extends UIComponent
{
		protected var animationCount : uint;
		protected var bar : Sprite;
		protected var barMask : Sprite;
		protected var patternBmp : BitmapData;
		private static var defaultStyles : Object;
		public function get visible () : Boolean;
		public function set visible (value:Boolean) : Void;
		public static function getStyleDefinition () : Object;
		public function IndeterminateBar ();
		protected function startAnimation () : void;
		protected function stopAnimation () : void;
		protected function handleEnterFrame (event:Event) : void;
		protected function configUI () : void;
		protected function draw () : void;
		protected function drawPattern () : void;
		protected function drawMask () : void;
		protected function drawBar () : void;
}
}
