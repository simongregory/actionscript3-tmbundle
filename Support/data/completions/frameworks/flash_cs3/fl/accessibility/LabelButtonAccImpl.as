package fl.accessibility
{
import flash.accessibility.Accessibility;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import fl.controls.LabelButton;
import fl.core.UIComponent;
import fl.events.ComponentEvent;
public class LabelButtonAccImpl extends AccImpl
{
		private static var accessibilityHooked : Boolean;
		private static const STATE_SYSTEM_PRESSED : uint;
		private static const EVENT_OBJECT_NAMECHANGE : uint;
		private static const EVENT_OBJECT_STATECHANGE : uint;
		protected function get eventsToHandle () : Array;
		private static function hookAccessibility () : Boolean;
		public static function createAccessibilityImplementation (component:UIComponent) : void;
		public static function enableAccessibility () : void;
		public function LabelButtonAccImpl (component:UIComponent);
		public function get_accState (childID:uint) : uint;
		public function get_accDefaultAction (childID:uint) : String;
		public function accDoDefaultAction (childID:uint) : void;
		protected function getName (childID:uint) : String;
		protected function eventHandler (event:Event) : void;
}
}
