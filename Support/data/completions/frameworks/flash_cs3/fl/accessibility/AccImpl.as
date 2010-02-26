package fl.accessibility
{
import flash.accessibility.Accessibility;
import flash.accessibility.AccessibilityImplementation;
import flash.accessibility.AccessibilityProperties;
import flash.events.Event;
import fl.core.UIComponent;
import flash.display.MovieClip;
import flash.text.TextField;
public class AccImpl extends AccessibilityImplementation
{
		private static const STATE_SYSTEM_NORMAL : uint;
		private static const STATE_SYSTEM_FOCUSABLE : uint;
		private static const STATE_SYSTEM_FOCUSED : uint;
		private static const STATE_SYSTEM_UNAVAILABLE : uint;
		private static const EVENT_OBJECT_NAMECHANGE : uint;
		protected var master : UIComponent;
		protected var role : uint;
		protected function get eventsToHandle () : Array;
		public static function createAccessibilityImplementation (component:UIComponent) : void;
		public static function enableAccessibility () : void;
		public function AccImpl (component:UIComponent);
		public function get_accRole (childID:uint) : uint;
		public function get_accName (childID:uint) : String;
		protected function getName (childID:uint) : String;
		protected function getState (childID:uint) : uint;
		private function getStatusName () : String;
		protected function eventHandler (event:Event) : void;
}
}
