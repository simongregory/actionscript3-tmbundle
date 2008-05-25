package flash.net
{
	import flash.net.URLRequest;
	import flash.events.EventDispatcher;

	public class FileReference extends EventDispatcher
	{
		public var creationDate:Date;
		public var creator:String;
		public var modificationDate:Date;
		public var name:String;
		public var size:uint;
		public var type:String;
		public function FileReference();
		public function browse(typeFilter:Array = null):Boolean;
		public function cancel():void;
		public function download(request:URLRequest, defaultFileName:String = null):void;
		public function upload(request:URLRequest, uploadDataFieldName:String = "Filedata", testUpload:Boolean = false):void;
	}
}