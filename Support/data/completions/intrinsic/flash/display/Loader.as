package flash.display {
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	public class Loader extends DisplayObjectContainer {
		public function get content():DisplayObject;
		public function get contentLoaderInfo():LoaderInfo;
		public function Loader();
		public function close():void;
		public function load(request:URLRequest, context:LoaderContext = null):void;
		public function loadBytes(bytes:ByteArray, context:LoaderContext = null):void;
		public function unload():void;
	}
}
