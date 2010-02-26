package fl.transitions
{
import flash.events.Event;
public class TweenEvent extends Event
{
		public static const MOTION_START : String;
		public static const MOTION_STOP : String;
		public static const MOTION_FINISH : String;
		public static const MOTION_CHANGE : String;
		public static const MOTION_RESUME : String;
		public static const MOTION_LOOP : String;
		public var time : Number;
		public var position : Number;
		public function TweenEvent (type:String, time:Number, position:Number, bubbles:Boolean =false, cancelable:Boolean =false);
		public function clone () : Event;
}
}
