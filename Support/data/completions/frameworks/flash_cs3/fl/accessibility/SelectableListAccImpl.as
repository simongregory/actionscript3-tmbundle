package fl.accessibility
{
import flash.events.Event;
import flash.accessibility.Accessibility;
import fl.controls.listClasses.ICellRenderer;
import fl.controls.SelectableList;
import fl.core.UIComponent;
public class SelectableListAccImpl extends AccImpl
{
		private static var accessibilityHooked : Boolean;
		private static const ROLE_SYSTEM_LISTITEM : uint;
		private static const STATE_SYSTEM_FOCUSED : uint;
		private static const STATE_SYSTEM_INVISIBLE : uint;
		private static const STATE_SYSTEM_OFFSCREEN : uint;
		private static const STATE_SYSTEM_SELECTABLE : uint;
		private static const STATE_SYSTEM_SELECTED : uint;
		private static const EVENT_OBJECT_FOCUS : uint;
		private static const EVENT_OBJECT_SELECTION : uint;
		protected function get eventsToHandle () : Array;
		private static function hookAccessibility () : Boolean;
		public static function createAccessibilityImplementation (component:UIComponent) : void;
		public static function enableAccessibility () : void;
		public function SelectableListAccImpl (master:UIComponent);
		public function get_accRole (childID:uint) : uint;
		public function get_accValue (childID:uint) : String;
		public function get_accState (childID:uint) : uint;
		public function get_accDefaultAction (childID:uint) : String;
		public function accDoDefaultAction (childID:uint) : void;
		public function getChildIDArray () : Array;
		public function accLocation (childID:uint) : *;
		public function get_accSelection () : Array;
		public function get_accFocus () : uint;
		public function accSelect (selFlag:uint, childID:uint) : void;
		protected function getName (childID:uint) : String;
		protected function eventHandler (event:Event) : void;
}
}
