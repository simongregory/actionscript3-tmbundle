package fl.controls.dataGridClasses
{
import fl.controls.LabelButton;
import fl.controls.listClasses.ListData;
import fl.controls.listClasses.ICellRenderer;
import fl.controls.TextInput;
import fl.core.UIComponent;
import flash.events.Event;
import flash.events.MouseEvent;
public class DataGridCellEditor extends TextInput implements ICellRenderer
{
		protected var _listData : ListData;
		protected var _data : Object;
		private static var defaultStyles : Object;
		public function get listData () : ListData;
		public function set listData (value:ListData) : Void;
		public function get data () : Object;
		public function set data (value:Object) : Void;
		public function get selected () : Boolean;
		public function set selected (value:Boolean) : Void;
		public function DataGridCellEditor ();
		public static function getStyleDefinition () : Object;
		public function setMouseState (state:String) : void;
}
}
