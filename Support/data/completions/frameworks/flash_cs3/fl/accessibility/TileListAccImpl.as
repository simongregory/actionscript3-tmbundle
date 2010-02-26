package fl.accessibility
{
import flash.accessibility.Accessibility;
import flash.events.Event;
import fl.controls.listClasses.ICellRenderer;
import fl.controls.TileList;
import fl.core.UIComponent;
public class TileListAccImpl extends SelectableListAccImpl
{
		private static var accessibilityHooked : Boolean;
		private static function hookAccessibility () : Boolean;
		public static function createAccessibilityImplementation (component:UIComponent) : void;
		public static function enableAccessibility () : void;
		public function TileListAccImpl (master:UIComponent);
		public function get_accValue (childID:uint) : String;
		protected function getName (childID:uint) : String;
}
}
