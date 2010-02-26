package fl.accessibility
{
import fl.controls.RadioButton;
import fl.core.UIComponent;
public class RadioButtonAccImpl extends CheckBoxAccImpl
{
		private static var accessibilityHooked : Boolean;
		private static function hookAccessibility () : Boolean;
		public static function createAccessibilityImplementation (component:UIComponent) : void;
		public static function enableAccessibility () : void;
		public function RadioButtonAccImpl (master:UIComponent);
}
}
