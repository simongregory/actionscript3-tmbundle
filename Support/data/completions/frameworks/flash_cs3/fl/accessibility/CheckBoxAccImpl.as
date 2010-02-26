package fl.accessibility
{
import fl.controls.LabelButton;
import fl.controls.CheckBox;
import fl.core.UIComponent;
public class CheckBoxAccImpl extends LabelButtonAccImpl
{
		private static var accessibilityHooked : Boolean;
		private static const STATE_SYSTEM_CHECKED : uint;
		private static function hookAccessibility () : Boolean;
		public static function createAccessibilityImplementation (component:UIComponent) : void;
		public static function enableAccessibility () : void;
		public function CheckBoxAccImpl (component:UIComponent);
		public function get_accState (childID:uint) : uint;
		public function get_accDefaultAction (childID:uint) : String;
}
}
