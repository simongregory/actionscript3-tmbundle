package flash.text {
	public class Font {
		public function get fontName():String;
		public function get fontStyle():String;
		public function get fontType():String;
		public static function enumerateFonts(enumerateDeviceFonts:Boolean = false):Array;
		public function hasGlyphs(str:String):Boolean;
		public static function registerFont(font:Class):void;
	}
}
