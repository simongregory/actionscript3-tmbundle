package fl.video
{
import flash.events.Event;
import flash.geom.Rectangle;
public class AutoLayoutEvent extends LayoutEvent implements IVPEvent
{
		public static const AUTO_LAYOUT : String;
		private var _vp : uint;
		public function get vp () : uint;
		public function set vp (n:uint) : Void;
		public function AutoLayoutEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldBounds:Rectangle = null, oldRegistrationBounds:Rectangle = null, vp:uint =0 );
		public function clone () : Event;
}
}
