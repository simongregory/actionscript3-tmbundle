package fl.events
{
import flash.events.Event;
public class DataChangeEvent extends Event
{
		public static const DATA_CHANGE : String;
		public static const PRE_DATA_CHANGE : String;
		protected var _startIndex : uint;
		protected var _endIndex : uint;
		protected var _changeType : String;
		protected var _items : Array;
		public function get changeType () : String;
		public function get items () : Array;
		public function get startIndex () : uint;
		public function get endIndex () : uint;
		public function DataChangeEvent (eventType:String, changeType:String, items:Array, startIndex:int =-1, endIndex:int =-1);
		public function toString () : String;
		public function clone () : Event;
}
}
