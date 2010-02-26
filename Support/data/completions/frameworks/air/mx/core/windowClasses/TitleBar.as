package mx.core.windowClasses {
	import mx.core.UIComponent;
	import flash.events.MouseEvent;
	public class TitleBar extends UIComponent {
		public var closeButton:Button;
		public var maximizeButton:Button;
		public var minimizeButton:Button;
		public function get title():String;
		public function set title(value:String):void;
		public function get titleIcon():Class;
		public function set titleIcon(value:Class):void;
		public var titleTextField:IUITextField;
		public function TitleBar();
		protected function doubleClickHandler(event:MouseEvent):void;
		protected function placeButtons(align:String, unscaledWidth:Number, unscaledHeight:Number, leftOffset:Number, rightOffset:Number, cornerOffset:Number):void;
		protected function placeTitle(titleAlign:String, leftOffset:Number, rightOffset:Number, buttonAlign:String):void;
		public override function styleChanged(styleProp:String):void;
	}
}
