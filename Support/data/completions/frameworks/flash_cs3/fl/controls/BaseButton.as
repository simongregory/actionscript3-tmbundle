package fl.controls
{
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.events.ComponentEvent;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;
public class BaseButton extends UIComponent
{
		protected var background : DisplayObject;
		protected var mouseState : String;
		protected var _selected : Boolean;
		protected var _autoRepeat : Boolean;
		protected var pressTimer : Timer;
		private var _mouseStateLocked : Boolean;
		private var unlockedMouseState : String;
		private static var defaultStyles : Object;
		public function get enabled () : Boolean;
		public function set enabled (value:Boolean) : Void;
		public function get selected () : Boolean;
		public function set selected (value:Boolean) : Void;
		public function get autoRepeat () : Boolean;
		public function set autoRepeat (value:Boolean) : Void;
		public function set mouseStateLocked (value:Boolean) : Void;
		public static function getStyleDefinition () : Object;
		public function BaseButton ();
		public function setMouseState (state:String) : void;
		protected function setupMouseEvents () : void;
		protected function mouseEventHandler (event:MouseEvent) : void;
		protected function startPress () : void;
		protected function buttonDown (event:TimerEvent) : void;
		protected function endPress () : void;
		protected function draw () : void;
		protected function drawBackground () : void;
		protected function drawLayout () : void;
}
}
