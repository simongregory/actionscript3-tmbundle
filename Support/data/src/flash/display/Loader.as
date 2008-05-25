package flash.display
{
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.display.DisplayObjectContainer;

	public class Loader extends DisplayObjectContainer
	{
		public var content:DisplayObject;
		public var contentLoaderInfo:LoaderInfo;
		public function Loader();
		public function close():void;
		public function load(request:URLRequest, context:LoaderContext = null):void;
		public function loadBytes(bytes:ByteArray, context:LoaderContext = null):void;
		public function unload():void;
	}
}