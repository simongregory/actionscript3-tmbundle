package flash.text
{
	public class Font
	{
		public var fontName:String;
		public var fontStyle:String;
		public var fontType:String;
		public static function enumerateFonts(enumerateDeviceFonts:Boolean = false):Array;
		public function hasGlyphs(str:String):Boolean;
		public static function registerFont(font:Class):void;
	}
}