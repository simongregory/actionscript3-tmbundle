package fl.controls
{
import fl.controls.BaseButton;
import fl.controls.TextInput;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.events.ComponentEvent;
import fl.managers.IFocusManagerComponent;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.ui.Keyboard;
public class NumericStepper extends UIComponent implements IFocusManagerComponent
{
		protected var inputField : TextInput;
		protected var upArrow : BaseButton;
		protected var downArrow : BaseButton;
		protected var _maximum : Number;
		protected var _minimum : Number;
		protected var _value : Number;
		protected var _stepSize : Number;
		protected var _precision : Number;
		private static var defaultStyles : Object;
		protected static const DOWN_ARROW_STYLES : Object;
		protected static const UP_ARROW_STYLES : Object;
		protected static const TEXT_INPUT_STYLES : Object;
		public function get enabled () : Boolean;
		public function set enabled (value:Boolean) : Void;
		public function get maximum () : Number;
		public function set maximum (value:Number) : Void;
		public function get minimum () : Number;
		public function set minimum (value:Number) : Void;
		public function get nextValue () : Number;
		public function get previousValue () : Number;
		public function get stepSize () : Number;
		public function set stepSize (value:Number) : Void;
		public function get value () : Number;
		public function set value (value:Number) : Void;
		public function get textField () : TextInput;
		public function get imeMode () : String;
		public function set imeMode (value:String) : Void;
		public function NumericStepper ();
		public static function getStyleDefinition () : Object;
		protected function configUI () : void;
		protected function setValue (value:Number, fireEvent:Boolean =true) : void;
		protected function keyDownHandler (event:KeyboardEvent) : void;
		protected function stepperPressHandler (event:ComponentEvent) : void;
		public function drawFocus (event:Boolean) : void;
		protected function focusOutHandler (event:FocusEvent) : void;
		protected function draw () : void;
		protected function drawLayout () : void;
		protected function onTextChange (event:Event) : void;
		protected function passEvent (event:Event) : void;
		public function setFocus () : void;
		protected function isOurFocus (target:DisplayObject) : Boolean;
		protected function setStyles () : void;
		protected function inRange (num:Number) : Boolean;
		protected function inStep (num:Number) : Boolean;
		protected function getValidValue (num:Number) : Number;
		protected function getPrecision () : Number;
}
}
