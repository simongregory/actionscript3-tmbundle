package fl.video
{
import flash.events.Event;
import flash.media.SoundTransform;
public class SoundEvent extends Event
{
		public static const SOUND_UPDATE : String;
		private var _soundTransform : SoundTransform;
		public function get soundTransform () : SoundTransform;
		public function SoundEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false, soundTransform:SoundTransform =null);
		public function clone () : Event;
}
}
