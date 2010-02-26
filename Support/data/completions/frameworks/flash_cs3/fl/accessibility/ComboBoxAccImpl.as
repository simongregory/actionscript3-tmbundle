package fl.accessibility
{
import flash.accessibility.Accessibility;
import flash.events.Event;
import fl.controls.ComboBox;
import fl.core.UIComponent;
public class ComboBoxAccImpl extends AccImpl
{
		private static var accessibilityHooked : Boolean;
		private static const ROLE_SYSTEM_LISTITEM : uint;
		private static const STATE_SYSTEM_FOCUSED : uint;
		private static const STATE_SYSTEM_SELECTABLE : uint;
		private static const STATE_SYSTEM_SELECTED : uint;
		private static const EVENT_OBJECT_VALUECHANGE : uint;
		private static const EVENT_OBJECT_SELECTION : uint;
		protected function get eventsToHandle () : Array;
		private static function hookAccessibility () : Boolean;
		public static function createAccessibilityImplementation (component:UIComponent) : void;
		public static function enableAccessibility () : void;
		public function ComboBoxAccImpl (master:UIComponent);
		public function get_accRole (childID:uint) : uint;
		public function get_accValue (childID:uint) : String;
		public function get_accState (childID:uint) : uint;
		public function getChildIDArray () : Array;
		protected function getName (childID:uint) : String;
		protected function eventHandler (event:Event) : void;
}
}
