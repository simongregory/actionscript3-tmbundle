package flash.desktop {
	public class Clipboard {
		public function get formats():Array;
		public static function get generalClipboard():Clipboard;
		public function Clipboard();
		public function clear():void;
		public function clearData(format:String):void;
		public function getData(format:String, transferMode:String):Object;
		public function hasFormat(format:String):Boolean;
		public function setData(format:String, data:Object, serializable:Boolean = true):Boolean;
		public function setDataHandler(format:String, handler:Function, serializable:Boolean = true):Boolean;
	}
}
