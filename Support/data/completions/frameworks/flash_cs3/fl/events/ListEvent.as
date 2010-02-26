package fl.events
{
import flash.events.Event;
public class ListEvent extends Event
{
		public static const ITEM_ROLL_OUT : String;
		public static const ITEM_ROLL_OVER : String;
		public static const ITEM_CLICK : String;
		public static const ITEM_DOUBLE_CLICK : String;
		protected var _rowIndex : int;
		protected var _columnIndex : int;
		protected var _index : int;
		protected var _item : Object;
		public function get rowIndex () : Object;
		public function get columnIndex () : int;
		public function get index () : int;
		public function get item () : Object;
		public function ListEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false, columnIndex:int =-1, rowIndex:int =-1, index:int =-1, item:Object =null);
		public function toString () : String;
		public function clone () : Event;
}
}
