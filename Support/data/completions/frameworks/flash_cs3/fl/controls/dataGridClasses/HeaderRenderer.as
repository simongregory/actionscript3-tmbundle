package fl.controls.dataGridClasses
{
import fl.controls.ButtonLabelPlacement;
import fl.controls.LabelButton;
import fl.core.UIComponent;
import flash.events.Event;
import flash.events.MouseEvent;
public class HeaderRenderer extends LabelButton
{
		public var _column : uint;
		private static var defaultStyles : Object;
		public function get column () : uint;
		public function set column (value:uint) : Void;
		public function HeaderRenderer ();
		public static function getStyleDefinition () : Object;
		protected function drawLayout () : void;
}
}
