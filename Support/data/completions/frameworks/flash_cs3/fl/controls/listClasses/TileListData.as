package fl.controls.listClasses
{
import fl.controls.listClasses.ListData;
import fl.core.UIComponent;
public class TileListData extends ListData
{
		protected var _source : Object;
		public function get source () : Object;
		public function TileListData (label:String, icon:Object, source:Object, owner:UIComponent, index:uint, row:uint, col:uint =0);
}
}
