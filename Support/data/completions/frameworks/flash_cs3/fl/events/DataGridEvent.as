package fl.events
{
import flash.events.Event;
import fl.events.ListEvent;
public class DataGridEvent extends ListEvent
{
		public static const COLUMN_STRETCH : String;
		public static const HEADER_RELEASE : String;
		public static const ITEM_EDIT_BEGINNING : String;
		public static const ITEM_EDIT_BEGIN : String;
		public static const ITEM_EDIT_END : String;
		public static const ITEM_FOCUS_IN : String;
		public static const ITEM_FOCUS_OUT : String;
		protected var _dataField : String;
		protected var _itemRenderer : Object;
		protected var _reason : String;
		public function get itemRenderer () : Object;
		public function get dataField () : String;
		public function set dataField (value:String) : Void;
		public function get reason () : String;
		public function DataGridEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false, columnIndex:int =-1, rowIndex:int =-1, itemRenderer:Object =null, dataField:String =null, reason:String =null);
		public function toString () : String;
		public function clone () : Event;
}
}
