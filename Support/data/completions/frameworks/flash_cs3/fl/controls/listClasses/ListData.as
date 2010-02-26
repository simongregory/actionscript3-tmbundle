package fl.controls.listClasses
{
import fl.core.UIComponent;
public class ListData
{
		protected var _icon : Object;
		protected var _label : String;
		protected var _owner : UIComponent;
		protected var _index : uint;
		protected var _row : uint;
		protected var _column : uint;
		public function get label () : String;
		public function get icon () : Object;
		public function get owner () : UIComponent;
		public function get index () : uint;
		public function get row () : uint;
		public function get column () : uint;
		public function ListData (label:String, icon:Object, owner:UIComponent, index:uint, row:uint, col:uint =0);
}
}
