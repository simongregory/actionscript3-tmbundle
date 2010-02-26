package fl.video
{
import flash.events.Event;
import flash.events.ProgressEvent;
public class VideoProgressEvent extends ProgressEvent implements IVPEvent
{
		public static const PROGRESS : String;
		private var _vp : uint;
		public function get vp () : uint;
		public function set vp (n:uint) : Void;
		public function VideoProgressEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false, bytesLoaded:uint =0, bytesTotal:uint =0, vp:uint =0);
		public function clone () : Event;
}
}
