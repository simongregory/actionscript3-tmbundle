package fl.events
{
import flash.events.Event;
public class ComponentEvent extends Event
{
		public static const BUTTON_DOWN : String;
		public static const LABEL_CHANGE : String;
		public static const HIDE : String;
		public static const SHOW : String;
		public static const RESIZE : String;
		public static const MOVE : String;
		public static const ENTER : String;
		public function ComponentEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false);
		public function toString () : String;
		public function clone () : Event;
}
}
