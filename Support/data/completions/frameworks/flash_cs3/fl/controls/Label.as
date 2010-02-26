package fl.controls
{
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.events.ComponentEvent;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TextEvent;
import fl.controls.TextInput;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
public class Label extends UIComponent
{
		public var textField : TextField;
		protected var actualWidth : Number;
		protected var actualHeight : Number;
		protected var defaultLabel : String;
		protected var _savedHTML : String;
		protected var _html : Boolean;
		private static var defaultStyles : Object;
		public function get text () : String;
		public function set text (value:String) : Void;
		public function get htmlText () : String;
		public function set htmlText (value:String) : Void;
		public function get condenseWhite () : Boolean;
		public function set condenseWhite (value:Boolean) : Void;
		public function get selectable () : Boolean;
		public function set selectable (value:Boolean) : Void;
		public function get wordWrap () : Boolean;
		public function set wordWrap (value:Boolean) : Void;
		public function get autoSize () : String;
		public function set autoSize (value:String) : Void;
		public function get width () : Number;
		public function set width (value:Number) : Void;
		public function get height () : Number;
		public static function getStyleDefinition () : Object;
		public function Label ();
		public function setSize (width:Number, height:Number) : void;
		protected function configUI () : void;
		protected function draw () : void;
		protected function drawTextFormat () : void;
		protected function drawLayout () : void;
}
}
