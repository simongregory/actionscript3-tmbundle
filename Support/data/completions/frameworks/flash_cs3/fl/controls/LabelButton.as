package fl.controls
{
import fl.controls.BaseButton;
import fl.controls.ButtonLabelPlacement;
import fl.controls.TextInput;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.events.ComponentEvent;
import fl.managers.IFocusManagerComponent;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.ui.Keyboard;
public class LabelButton extends BaseButton implements IFocusManagerComponent
{
		public var textField : TextField;
		protected var _labelPlacement : String;
		protected var _toggle : Boolean;
		protected var icon : DisplayObject;
		protected var oldMouseState : String;
		protected var _label : String;
		protected var mode : String;
		private static var defaultStyles : Object;
		public static var createAccessibilityImplementation : Function;
		public function get label () : String;
		public function set label (value:String) : Void;
		public function get labelPlacement () : String;
		public function set labelPlacement (value:String) : Void;
		public function get toggle () : Boolean;
		public function set toggle (value:Boolean) : Void;
		public function get selected () : Boolean;
		public function set selected (value:Boolean) : Void;
		public static function getStyleDefinition () : Object;
		public function LabelButton ();
		protected function toggleSelected (event:MouseEvent) : void;
		protected function configUI () : void;
		protected function draw () : void;
		protected function drawIcon () : void;
		protected function drawTextFormat () : void;
		protected function setEmbedFont ();
		protected function drawLayout () : void;
		protected function keyDownHandler (event:KeyboardEvent) : void;
		protected function keyUpHandler (event:KeyboardEvent) : void;
		protected function initializeAccessibility () : void;
}
}
