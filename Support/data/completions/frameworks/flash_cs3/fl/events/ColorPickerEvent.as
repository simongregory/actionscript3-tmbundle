package fl.events
{
import flash.events.Event;
public class ColorPickerEvent extends Event
{
		public static const ITEM_ROLL_OUT : String;
		public static const ITEM_ROLL_OVER : String;
		public static const ENTER : String;
		public static const CHANGE : String;
		protected var _color : uint;
		public function get color () : uint;
		public function ColorPickerEvent (type:String, color:uint);
		public function toString () : String;
		public function clone () : Event;
}
}
