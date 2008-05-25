package flash.display
{
	import flash.system.ApplicationDomain;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.EventDispatcher;
	import flash.events.EventDispatcher;

	public class LoaderInfo extends EventDispatcher
	{
		public var actionScriptVersion:uint;
		public var applicationDomain:ApplicationDomain;
		public var bytesLoaded:uint;
		public var bytesTotal:uint;
		public var childAllowsParent:Boolean;
		public var content:DisplayObject;
		public var contentType:String;
		public var frameRate:Number;
		public var height:int;
		public var loader:Loader;
		public var loaderURL:String;
		public var parameters:Object;
		public var parentAllowsChild:Boolean;
		public var sameDomain:Boolean;
		public var sharedEvents:EventDispatcher;
		public var swfVersion:uint;
		public var url:String;
		public var width:int;
	}
}