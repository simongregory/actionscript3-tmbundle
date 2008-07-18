package flash.text {
	public class TextSnapshot {
		public function get charCount():int;
		public function findText(beginIndex:int, textToFind:String, caseSensitive:Boolean):int;
		public function getSelected(beginIndex:int, endIndex:int):Boolean;
		public function getSelectedText(includeLineEndings:Boolean = false):String;
		public function getText(beginIndex:int, endIndex:int, includeLineEndings:Boolean = false):String;
		public function getTextRunInfo(beginIndex:int, endIndex:int):Array;
		public function hitTestTextNearPos(x:Number, y:Number, maxDistance:Number = 0):Number;
		public function setSelectColor(hexColor:uint = 0xFFFF00):void;
		public function setSelected(beginIndex:int, endIndex:int, select:Boolean):void;
	}
}
