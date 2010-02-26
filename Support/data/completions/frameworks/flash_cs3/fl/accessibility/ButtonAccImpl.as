package fl.accessibility
{
import fl.controls.Button;
import fl.core.UIComponent;
public class ButtonAccImpl extends LabelButtonAccImpl
{
		private static var accessibilityHooked : Boolean;
		private static function hookAccessibility () : Boolean;
		public static function createAccessibilityImplementation (component:UIComponent) : void;
		public static function enableAccessibility () : void;
		public function ButtonAccImpl (component:UIComponent);
}
}
