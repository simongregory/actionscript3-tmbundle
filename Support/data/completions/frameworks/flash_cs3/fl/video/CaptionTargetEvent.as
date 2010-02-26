package fl.video
{
import flash.display.DisplayObject;
import flash.events.Event;
public class CaptionTargetEvent extends Event
{
		public static const CAPTION_TARGET_CREATED : String;
		private var _captionTarget : DisplayObject;
		public function get captionTarget () : DisplayObject;
		public function set captionTarget (d:DisplayObject) : Void;
		public function CaptionTargetEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false, captionTarget:DisplayObject =null );
		public function clone () : Event;
}
}
