package fl.events
{
import flash.events.Event;
public class ScrollEvent extends Event
{
		public static const SCROLL : String;
		private var _direction : String;
		private var _delta : Number;
		private var _position : Number;
		public function get direction () : String;
		public function get delta () : Number;
		public function get position () : Number;
		public function ScrollEvent (direction:String, delta:Number, position:Number);
		public function toString () : String;
		public function clone () : Event;
}
}
