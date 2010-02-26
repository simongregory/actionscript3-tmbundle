package mx.core.windowClasses {
	import mx.core.UIComponent;
	public class StatusBar extends UIComponent {
		public function get status():String;
		public function set status(value:String):void;
		public var statusTextField:IUITextField;
		public function StatusBar();
	}
}
