package mx.core {
	import flash.html.HTMLLoader;
	import mx.managers.IFocusManagerComplexComponent;
	public class FlexHTMLLoader extends HTMLLoader implements IFocusManagerComplexComponent {
		public function get focusEnabled():Boolean;
		public function set focusEnabled(value:Boolean):void;
		public function get mouseFocusEnabled():Boolean;
		public function set mouseFocusEnabled(value:Boolean):void;
		public function FlexHTMLLoader();
		public function assignFocus(direction:String):void;
		public function drawFocus(isFocused:Boolean):void;
		public function setFocus():void;
		public override function toString():String;
	}
}
