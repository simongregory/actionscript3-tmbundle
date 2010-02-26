package fl.accessibility
{
import flash.accessibility.Accessibility;
import flash.accessibility.AccessibilityProperties;
import fl.controls.ScrollBar;
import fl.core.UIComponent;
import flash.events.Event;
public class UIComponentAccImpl extends AccessibilityProperties
{
		private static var accessibilityHooked : Boolean;
		protected var master : UIComponent;
		private static function hookAccessibility () : Boolean;
		public static function createAccessibilityImplementation (component:UIComponent) : void;
		public static function enableAccessibility () : void;
		public function UIComponentAccImpl (component:UIComponent);
		protected function eventHandler (event:Event) : void;
}
}
