package mx.controls {
	import flash.filesystem.File;
	public class FileSystemTree extends Tree {
		public function get directory():File;
		public function set directory(value:File):void;
		public function get enumerationMode():String;
		public function set enumerationMode(value:String):void;
		public function get extensions():Array;
		public function set extensions(value:Array):void;
		public function get filterFunction():Function;
		public function set filterFunction(value:Function):void;
		public function get nameCompareFunction():Function;
		public function set nameCompareFunction(value:Function):void;
		public function get openPaths():Array;
		public function set openPaths(value:Array):void;
		public function get selectedPath():String;
		public function set selectedPath(value:String):void;
		public function get selectedPaths():Array;
		public function set selectedPaths(value:Array):void;
		public function get showExtensions():Boolean;
		public function set showExtensions(value:Boolean):void;
		public function get showHidden():Boolean;
		public function set showHidden(value:Boolean):void;
		public function get showIcons():Boolean;
		public function set showIcons(value:Boolean):void;
		public function FileSystemTree();
		public function clear():void;
		public function closeSubdirectory(nativePath:String):void;
		public function findIndex(nativePath:String):int;
		public function findItem(nativePath:String):File;
		public function openSubdirectory(nativePath:String):void;
		public function refresh():void;
		public static const COMPUTER:File;
	}
}
