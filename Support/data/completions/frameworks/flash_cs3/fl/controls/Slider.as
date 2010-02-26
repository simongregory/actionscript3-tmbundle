package fl.controls
{
import fl.controls.BaseButton;
import fl.controls.SliderDirection;
import fl.controls.ScrollBar;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.events.SliderEvent;
import fl.events.InteractionInputType;
import fl.events.SliderEventClickTarget;
import fl.managers.IFocusManagerComponent;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
public class Slider extends UIComponent implements IFocusManagerComponent
{
		protected var _direction : String;
		protected var _minimum : Number;
		protected var _maximum : Number;
		protected var _value : Number;
		protected var _tickInterval : Number;
		protected var _snapInterval : Number;
		protected var _liveDragging : Boolean;
		protected var tickContainer : Sprite;
		protected var thumb : BaseButton;
		protected var track : BaseButton;
		protected static var defaultStyles : Object;
		protected static const TRACK_STYLES : Object;
		protected static const THUMB_STYLES : Object;
		protected static const TICK_STYLES : Object;
		public function get direction () : String;
		public function set direction (value:String) : Void;
		public function get minimum () : Number;
		public function set minimum (value:Number) : Void;
		public function get maximum () : Number;
		public function set maximum (value:Number) : Void;
		public function get tickInterval () : Number;
		public function set tickInterval (value:Number) : Void;
		public function get snapInterval () : Number;
		public function set snapInterval (value:Number) : Void;
		public function set liveDragging (value:Boolean) : Void;
		public function get liveDragging () : Boolean;
		public function get enabled () : Boolean;
		public function set enabled (value:Boolean) : Void;
		public function get value () : Number;
		public function set value (value:Number) : Void;
		public static function getStyleDefinition () : Object;
		public function Slider ();
		public function setSize (w:Number, h:Number) : void;
		protected function doSetValue (val:Number, interactionType:String =null, clickTarget:String =null, keyCode:int =undefined) : void;
		protected function setStyles () : void;
		protected function draw () : void;
		protected function positionThumb () : void;
		protected function drawTicks () : void;
		protected function clearTicks () : void;
		protected function calculateValue (pos:Number, interactionType:String, clickTarget:String, keyCode:int = undefined) : void;
		protected function doDrag (event:MouseEvent) : void;
		protected function thumbPressHandler (event:MouseEvent) : void;
		protected function thumbReleaseHandler (event:MouseEvent) : void;
		protected function onTrackClick (event:MouseEvent) : void;
		protected function keyDownHandler (event:KeyboardEvent) : void;
		protected function configUI () : void;
		protected function getPrecision (num:Number) : Number;
}
}
