package fl.video
{
import flash.events.Event;
import flash.geom.Rectangle;
public class LayoutEvent extends Event
{
		public static const LAYOUT : String;
		private var _oldBounds : Rectangle;
		private var _oldRegistrationBounds : Rectangle;
		public function get oldBounds () : Rectangle;
		public function set oldBounds (r:Rectangle) : Void;
		public function get oldRegistrationBounds () : Rectangle;
		public function set oldRegistrationBounds (r:Rectangle) : Void;
		public function LayoutEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldBounds:Rectangle = null, oldRegistrationBounds:Rectangle = null );
		public function clone () : Event;
}
}
