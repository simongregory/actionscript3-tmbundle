package mx.controls {
	import flash.filesystem.File;
	public class FileSystemComboBox extends ComboBox {
		public function get directory():File;
		public function set directory(value:File):void;
		public function get indent():int;
		public function set indent(value:int):void;
		public function get showIcons():Boolean;
		public function set showIcons(value:Boolean):void;
		public function FileSystemComboBox();
		public static const COMPUTER:File;
	}
}
