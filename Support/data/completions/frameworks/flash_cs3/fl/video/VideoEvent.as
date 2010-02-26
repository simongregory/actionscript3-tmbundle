package fl.video
{
import flash.events.Event;
public class VideoEvent extends Event implements IVPEvent
{
		public static const AUTO_REWOUND : String;
		public static const BUFFERING_STATE_ENTERED : String;
		public static const CLOSE : String;
		public static const COMPLETE : String;
		public static const FAST_FORWARD : String;
		public static const PAUSED_STATE_ENTERED : String;
		public static const PLAYHEAD_UPDATE : String;
		public static const PLAYING_STATE_ENTERED : String;
		public static const READY : String;
		public static const REWIND : String;
		public static const SCRUB_FINISH : String;
		public static const SCRUB_START : String;
		public static const SEEKED : String;
		public static const SKIN_LOADED : String;
		public static const STATE_CHANGE : String;
		public static const STOPPED_STATE_ENTERED : String;
		private var _state : String;
		private var _playheadTime : Number;
		private var _vp : uint;
		public function get state () : String;
		public function set state (s:String) : Void;
		public function get playheadTime () : Number;
		public function set playheadTime (t:Number) : Void;
		public function get vp () : uint;
		public function set vp (n:uint) : Void;
		public function VideoEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false, state:String =null, playheadTime:Number =NaN, vp:uint =0);
		public function clone () : Event;
}
}
