package fl.controls.listClasses
{
import fl.controls.ButtonLabelPlacement;
import fl.controls.listClasses.ListData;
import fl.controls.listClasses.ICellRenderer;
import fl.controls.LabelButton;
import fl.core.UIComponent;
import flash.events.Event;
import flash.events.MouseEvent;
public class CellRenderer extends LabelButton implements ICellRenderer
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
		public function CellRenderer ();
		public static function getStyleDefinition () : Object;
		public function setSize (width:Number, height:Number) : void;
		protected function toggleSelected (event:MouseEvent) : void;
		protected function drawLayout () : void;
}
}
