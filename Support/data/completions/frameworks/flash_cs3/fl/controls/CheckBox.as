package fl.controls
{
import fl.controls.ButtonLabelPlacement;
import fl.controls.LabelButton;
import fl.core.UIComponent;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Sprite;
import flash.display.Shape;
import Error;
public class CheckBox extends LabelButton
{
		private static var defaultStyles : Object;
		public static var createAccessibilityImplementation : Function;
		public function get toggle () : Boolean;
		public function set toggle (value:Boolean) : Void;
		public function get autoRepeat () : Boolean;
		public function set autoRepeat (value:Boolean) : Void;
		public static function getStyleDefinition () : Object;
		public function CheckBox ();
		protected function drawLayout () : void;
		protected function drawBackground () : void;
		public function drawFocus (focused:Boolean) : void;
		protected function initializeAccessibility () : void;
		protected function configUI () : void;
}
}
