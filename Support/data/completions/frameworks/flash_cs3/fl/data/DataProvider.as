package fl.data
{
import flash.events.EventDispatcher;
import fl.events.DataChangeEvent;
import fl.events.DataChangeType;
import RangeError;
public class DataProvider extends EventDispatcher
{
		protected var data : Array;
		public function get length () : uint;
		public function DataProvider (value:Object =null);
		public function invalidateItemAt (index:int) : void;
		public function invalidateItem (item:Object) : void;
		public function invalidate () : void;
		public function addItemAt (item:Object, index:uint) : void;
		public function addItem (item:Object) : void;
		public function addItemsAt (items:Object, index:uint) : void;
		public function addItems (items:Object) : void;
		public function concat (items:Object) : void;
		public function merge (newData:Object) : void;
		public function getItemAt (index:uint) : Object;
		public function getItemIndex (item:Object) : int;
		public function removeItemAt (index:uint) : Object;
		public function removeItem (item:Object) : Object;
		public function removeAll () : void;
		public function replaceItem (newItem:Object, oldItem:Object) : Object;
		public function replaceItemAt (newItem:Object, index:uint) : Object;
		public function sort (...sortArgs:Array) : *;
		public function sortOn (fieldName:Object, options:Object =null) : *;
		public function clone () : DataProvider;
		public function toArray () : Array;
		public function toString () : String;
		protected function getDataFromObject (obj:Object) : Array;
		protected function checkIndex (index:int, maximum:int) : void;
		protected function dispatchChangeEvent (evtType:String, items:Array, startIndex:int, endIndex:int) : void;
		protected function dispatchPreChangeEvent (evtType:String, items:Array, startIndex:int, endIndex:int) : void;
}
}
