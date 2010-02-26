package fl.controls.listClasses
{
import fl.controls.listClasses.CellRenderer;
import fl.controls.listClasses.ICellRenderer;
import fl.controls.listClasses.ListData;
import fl.controls.listClasses.TileListData;
import fl.controls.TextInput;
import fl.containers.UILoader;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import flash.display.Graphics;
import flash.display.Shape;
import flash.events.IOErrorEvent;
public class ImageCell extends CellRenderer implements ICellRenderer
{
		protected var textOverlay : Shape;
		protected var loader : UILoader;
		private static var defaultStyles : Object;
		public function get listData () : ListData;
		public function set listData (value:ListData) : Void;
		public function get source () : Object;
		public function set source (value:Object) : Void;
		public static function getStyleDefinition () : Object;
		public function ImageCell ();
		protected function configUI () : void;
		protected function draw () : void;
		protected function drawLayout () : void;
		protected function handleErrorEvent (event:IOErrorEvent) : void;
}
}
