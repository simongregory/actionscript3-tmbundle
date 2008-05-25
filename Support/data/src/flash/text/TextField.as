package flash.text
{
	import flash.text.TextFormat;
	import flash.text.StyleSheet;
	import flash.geom.Rectangle;
	import flash.display.DisplayObject;
	import flash.text.TextLineMetrics;
	import flash.display.InteractiveObject;

	public class TextField extends InteractiveObject
	{
		public var alwaysShowSelection:Boolean;
		public var antiAliasType:String;
		public var autoSize:String;
		public var background:Boolean;
		public var backgroundColor:uint;
		public var border:Boolean;
		public var borderColor:uint;
		public var bottomScrollV:int;
		public var caretIndex:int;
		public var condenseWhite:Boolean;
		public var defaultTextFormat:TextFormat;
		public var displayAsPassword:Boolean;
		public var embedFonts:Boolean;
		public var gridFitType:String;
		public var htmlText:String;
		public var length:int;
		public var maxChars:int;
		public var maxScrollH:int;
		public var maxScrollV:int;
		public var mouseWheelEnabled:Boolean;
		public var multiline:Boolean;
		public var numLines:int;
		public var restrict:String;
		public var scrollH:int;
		public var scrollV:int;
		public var selectable:Boolean;
		public var selectionBeginIndex:int;
		public var selectionEndIndex:int;
		public var sharpness:Number;
		public var styleSheet:StyleSheet;
		public var text:String;
		public var textColor:uint;
		public var textHeight:Number;
		public var textWidth:Number;
		public var thickness:Number;
		public var type:String;
		public var useRichTextClipboard:Boolean;
		public var wordWrap:Boolean;
		public function TextField();
		public function appendText(newText:String):void;
		public function getCharBoundaries(charIndex:int):Rectangle;
		public function getCharIndexAtPoint(x:Number, y:Number):int;
		public function getFirstCharInParagraph(charIndex:int):int;
		public function getImageReference(id:String):DisplayObject;
		public function getLineIndexAtPoint(x:Number, y:Number):int;
		public function getLineIndexOfChar(charIndex:int):int;
		public function getLineLength(lineIndex:int):int;
		public function getLineMetrics(lineIndex:int):TextLineMetrics;
		public function getLineOffset(lineIndex:int):int;
		public function getLineText(lineIndex:int):String;
		public function getParagraphLength(charIndex:int):int;
		public function getTextFormat(beginIndex:int = -1, endIndex:int = -1):TextFormat;
		public function replaceSelectedText(value:String):void;
		public function replaceText(beginIndex:int, endIndex:int, newText:String):void;
		public function setSelection(beginIndex:int, endIndex:int):void;
		public function setTextFormat(format:TextFormat, beginIndex:int = -1, endIndex:int = -1):void;
	}
}