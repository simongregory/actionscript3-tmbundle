package fl.controls.listClasses
{
import fl.controls.listClasses.ListData;
public interface ICellRenderer
{
		function set y (y:Number) : void;
		function set x (x:Number) : void;
		function get listData () : ListData;
		function set listData (value:ListData) : void;
		function get data () : Object;
		function set data (value:Object) : void;
		function get selected () : Boolean;
		function set selected (value:Boolean) : void;
		function setSize (width:Number, height:Number) : void;
		function setMouseState (state:String) : void;
}
}
