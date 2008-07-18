package flash.text {
	import flash.events.EventDispatcher;
	public dynamic  class StyleSheet extends EventDispatcher {
		public function get styleNames():Array;
		public function StyleSheet();
		public function clear():void;
		public function getStyle(styleName:String):Object;
		public function parseCSS(CSSText:String):void;
		public function setStyle(styleName:String, styleObject:Object):void;
		public function transform(formatObject:Object):TextFormat;
	}
}
