package fl.video
{
import flash.events.Event;
import flash.events.ErrorEvent;
public class SkinErrorEvent extends ErrorEvent
{
		public static const SKIN_ERROR : String;
		public function SkinErrorEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false, text:String ="");
		public function clone () : Event;
}
}
