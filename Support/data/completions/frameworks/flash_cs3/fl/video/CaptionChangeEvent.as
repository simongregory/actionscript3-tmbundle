package fl.video
{
import flash.events.Event;
public class CaptionChangeEvent extends Event
{
		public static const CAPTION_CHANGE : String;
		private var _added : Boolean;
		private var _captionCuePointObject : Object;
		public function get added () : Boolean;
		public function set added (b:Boolean) : Void;
		public function get captionCuePointObject () : Object;
		public function set captionCuePointObject (o:Object) : Void;
		public function CaptionChangeEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false, added:Boolean =true, captionCuePointObject:Object =null );
		public function clone () : Event;
}
}
