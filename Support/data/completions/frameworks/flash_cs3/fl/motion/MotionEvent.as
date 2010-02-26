package fl.motion
{
import flash.events.Event;
public class MotionEvent extends Event
{
		public static const MOTION_START : String;
		public static const MOTION_END : String;
		public static const MOTION_UPDATE : String;
		public static const TIME_CHANGE : String;
		public function MotionEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false);
		public function clone () : Event;
}
}
