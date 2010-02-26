package fl.controls.dataGridClasses
{
import fl.controls.DataGrid;
import fl.controls.listClasses.ICellRenderer;
import fl.core.InvalidationType;
import fl.controls.dataGridClasses.DataGridCellEditor;
public class DataGridColumn
{
		private var _columnName : String;
		private var _headerText : String;
		private var _minWidth : Number;
		private var _width : Number;
		private var _visible : Boolean;
		private var _cellRenderer : Object;
		private var _headerRenderer : Object;
		private var _labelFunction : Function;
		private var _sortCompareFunction : Function;
		private var _imeMode : String;
		public var owner : DataGrid;
		public var colNum : Number;
		public var explicitWidth : Number;
		public var sortable : Boolean;
		public var resizable : Boolean;
		public var editable : Boolean;
		public var itemEditor : Object;
		public var editorDataField : String;
		public var dataField : String;
		public var sortDescending : Boolean;
		public var sortOptions : uint;
		private var forceImport : DataGridCellEditor;
		public function get cellRenderer () : Object;
		public function set cellRenderer (value:Object) : Void;
		public function get headerRenderer () : Object;
		public function set headerRenderer (value:Object) : Void;
		public function get headerText () : String;
		public function set headerText (value:String) : Void;
		public function get imeMode () : String;
		public function set imeMode (value:String) : Void;
		public function get labelFunction () : Function;
		public function set labelFunction (value:Function) : Void;
		public function get minWidth () : Number;
		public function set minWidth (value:Number) : Void;
		public function get sortCompareFunction () : Function;
		public function set sortCompareFunction (value:Function) : Void;
		public function get visible () : Boolean;
		public function set visible (value:Boolean) : Void;
		public function get width () : Number;
		public function set width (value:Number) : Void;
		public function DataGridColumn (columnName:String = null);
		public function setWidth (value:Number) : void;
		public function itemToLabel (data:Object) : String;
		public function toString () : String;
}
}
