package fl.controls
{
import fl.controls.progressBarClasses.IndeterminateBar;
import fl.controls.ProgressBarDirection;
import fl.controls.ProgressBarMode;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;
public class ProgressBar extends UIComponent
{
		protected var track : DisplayObject;
		protected var determinateBar : DisplayObject;
		protected var indeterminateBar : UIComponent;
		protected var _direction : String;
		protected var _indeterminate : Boolean;
		protected var _mode : String;
		protected var _minimum : Number;
		protected var _maximum : Number;
		protected var _value : Number;
		protected var _source : Object;
		protected var _loaded : Number;
		private static var defaultStyles : Object;
		public function get direction () : String;
		public function set direction (value:String) : Void;
		public function get indeterminate () : Boolean;
		public function set indeterminate (value:Boolean) : Void;
		public function get minimum () : Number;
		public function set minimum (value:Number) : Void;
		public function get maximum () : Number;
		public function set maximum (value:Number) : Void;
		public function get value () : Number;
		public function set value (value:Number) : Void;
		public function set sourceName (name:String) : Void;
		public function get source () : Object;
		public function set source (value:Object) : Void;
		public function get percentComplete () : Number;
		public function get mode () : String;
		public function set mode (value:String) : Void;
		public static function getStyleDefinition () : Object;
		public function ProgressBar ();
		public function setProgress (value:Number, maximum:Number) : void;
		public function reset () : void;
		protected function _setProgress (value:Number, maximum:Number, fireEvent:Boolean =false) : void;
		protected function setIndeterminate (value:Boolean) : void;
		protected function resetProgress () : void;
		protected function setupSourceEvents () : void;
		protected function cleanupSourceEvents () : void;
		protected function pollSource (event:Event) : void;
		protected function handleProgress (event:ProgressEvent) : void;
		protected function handleComplete (event:Event) : void;
		protected function draw () : void;
		protected function drawTrack () : void;
		protected function drawBars () : void;
		protected function drawDeterminateBar () : void;
		protected function drawLayout () : void;
		protected function configUI () : void;
}
}
