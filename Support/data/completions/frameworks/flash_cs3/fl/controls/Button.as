package fl.controls
{
import fl.controls.LabelButton;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.managers.IFocusManagerComponent;
import flash.display.DisplayObject;
import flash.display.Sprite;
public class Button extends LabelButton implements IFocusManagerComponent
{
		protected var _emphasized : Boolean;
		protected var emphasizedBorder : DisplayObject;
		private static var defaultStyles : Object;
		public static var createAccessibilityImplementation : Function;
		public function get emphasized () : Boolean;
		public function set emphasized (value:Boolean) : Void;
		public static function getStyleDefinition () : Object;
		public function Button ();
		protected function draw () : void;
		protected function drawEmphasized () : void;
		public function drawFocus (focused:Boolean) : void;
		protected function initializeAccessibility () : void;
}
}
