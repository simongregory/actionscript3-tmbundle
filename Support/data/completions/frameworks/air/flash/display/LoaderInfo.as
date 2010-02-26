package flash.display {
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	public class LoaderInfo extends EventDispatcher {
		public function get actionScriptVersion():uint;
		public function get applicationDomain():ApplicationDomain;
		public function get bytes():ByteArray;
		public function get bytesLoaded():uint;
		public function get bytesTotal():uint;
		public function get childAllowsParent():Boolean;
		public function get childSandboxBridge():Object;
		public function set childSandboxBridge(value:Object):void;
		public function get content():DisplayObject;
		public function get contentType():String;
		public function get frameRate():Number;
		public function get height():int;
		public function get loader():Loader;
		public function get loaderURL():String;
		public function get parameters():Object;
		public function get parentAllowsChild():Boolean;
		public function get parentSandboxBridge():Object;
		public function set parentSandboxBridge(value:Object):void;
		public function get sameDomain():Boolean;
		public function get sharedEvents():EventDispatcher;
		public function get swfVersion():uint;
		public function get url():String;
		public function get width():int;
		public static function getLoaderInfoByDefinition(object:Object):LoaderInfo;
	}
}
