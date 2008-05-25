package flash.text
{
	public class TextFormat
	{
		public var align:String;
		public var blockIndent:Object;
		public var bold:Object;
		public var bullet:Object;
		public var color:Object;
		public var font:String;
		public var indent:Object;
		public var italic:Object;
		public var kerning:Object;
		public var leading:Object;
		public var leftMargin:Object;
		public var letterSpacing:Object;
		public var rightMargin:Object;
		public var size:Object;
		public var tabStops:Array;
		public var target:String;
		public var underline:Object;
		public var url:String;
		public function TextFormat(font:String = null, size:Object = null, color:Object = null, bold:Object = null, italic:Object = null, underline:Object = null, url:String = null, target:String = null, align:String = null, leftMargin:Object = null, rightMargin:Object = null, indent:Object = null, leading:Object = null);
	}
}