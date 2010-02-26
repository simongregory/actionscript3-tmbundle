package fl.controls
{
import fl.controls.ButtonLabelPlacement;
import fl.controls.LabelButton;
import fl.controls.RadioButtonGroup;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.managers.IFocusManager;
import fl.managers.IFocusManagerGroup;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
public class RadioButton extends LabelButton implements IFocusManagerGroup
{
		protected var _value : Object;
		protected var _group : RadioButtonGroup;
		protected var defaultGroupName : String;
		private static var defaultStyles : Object;
		public static var createAccessibilityImplementation : Function;
		public function get toggle () : Boolean;
		public function set toggle (value:Boolean) : Void;
		public function get autoRepeat () : Boolean;
		public function set autoRepeat (value:Boolean) : Void;
		public function get selected () : Boolean;
		public function set selected (value:Boolean) : Void;
		public function get groupName () : String;
		public function set groupName (group:String) : Void;
		public function get group () : RadioButtonGroup;
		public function set group (name:RadioButtonGroup) : Void;
		public function get value () : Object;
		public function set value (val:Object) : Void;
		public static function getStyleDefinition () : Object;
		public function RadioButton ();
		protected function configUI () : void;
		protected function drawLayout () : void;
		public function drawFocus (focused:Boolean) : void;
		protected function handleChange (event:Event) : void;
		protected function handleClick (event:MouseEvent) : void;
		protected function draw () : void;
		protected function drawBackground () : void;
		protected function initializeAccessibility () : void;
		protected function keyDownHandler (event:KeyboardEvent) : void;
		protected function keyUpHandler (event:KeyboardEvent) : void;
		private function setPrev (moveSelection:Boolean = true) : void;
		private function setNext (moveSelection:Boolean = true) : void;
		private function setThis () : void;
}
}
