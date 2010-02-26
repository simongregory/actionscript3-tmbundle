package fl.events
{
import flash.events.Event;
public class SliderEvent extends Event
{
		public static const CHANGE : String;
		public static const THUMB_DRAG : String;
		public static const THUMB_PRESS : String;
		public static const THUMB_RELEASE : String;
		protected var _triggerEvent : String;
		protected var _value : Number;
		protected var _keyCode : Number;
		protected var _clickTarget : String;
		public function get value () : Number;
		public function get keyCode () : Number;
		public function get triggerEvent () : String;
		public function get clickTarget () : String;
		public function SliderEvent (type:String, value:Number, clickTarget:String, triggerEvent:String, keyCode:int =0);
		public function toString () : String;
		public function clone () : Event;
}
}
