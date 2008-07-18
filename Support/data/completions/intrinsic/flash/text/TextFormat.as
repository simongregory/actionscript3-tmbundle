package flash.text {
	public class TextFormat {
		public function get align():String;
		public function set align(value:String):void;
		public function get blockIndent():Object;
		public function set blockIndent(value:Object):void;
		public function get bold():Object;
		public function set bold(value:Object):void;
		public function get bullet():Object;
		public function set bullet(value:Object):void;
		public function get color():Object;
		public function set color(value:Object):void;
		public function get font():String;
		public function set font(value:String):void;
		public function get indent():Object;
		public function set indent(value:Object):void;
		public function get italic():Object;
		public function set italic(value:Object):void;
		public function get kerning():Object;
		public function set kerning(value:Object):void;
		public function get leading():Object;
		public function set leading(value:Object):void;
		public function get leftMargin():Object;
		public function set leftMargin(value:Object):void;
		public function get letterSpacing():Object;
		public function set letterSpacing(value:Object):void;
		public function get rightMargin():Object;
		public function set rightMargin(value:Object):void;
		public function get size():Object;
		public function set size(value:Object):void;
		public function get tabStops():Array;
		public function set tabStops(value:Array):void;
		public function get target():String;
		public function set target(value:String):void;
		public function get underline():Object;
		public function set underline(value:Object):void;
		public function get url():String;
		public function set url(value:String):void;
		public function TextFormat(font:String = null, size:Object = null, color:Object = null, bold:Object = null, italic:Object = null, underline:Object = null, url:String = null, target:String = null, align:String = null, leftMargin:Object = null, rightMargin:Object = null, indent:Object = null, leading:Object = null);
	}
}
