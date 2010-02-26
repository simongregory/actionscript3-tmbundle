package fl.video
{
import flash.events.Event;
public class MetadataEvent extends Event implements IVPEvent
{
		public static const METADATA_RECEIVED : String;
		public static const CUE_POINT : String;
		private var _info : Object;
		private var _vp : uint;
		public function get info () : Object;
		public function set info (i:Object) : Void;
		public function get vp () : uint;
		public function set vp (n:uint) : Void;
		public function MetadataEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false, info:Object =null, vp:uint =0);
		public function clone () : Event;
}
}
