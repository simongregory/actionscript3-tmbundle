package flash.net {
	import flash.events.EventDispatcher;
	public class FileReference extends EventDispatcher {
		public function get creationDate():Date;
		public function get creator():String;
		public function get modificationDate():Date;
		public function get name():String;
		public function get size():Number;
		public function get type():String;
		public function FileReference();
		public function browse(typeFilter:Array = null):Boolean;
		public function cancel():void;
		public function download(request:URLRequest, defaultFileName:String = null):void;
		public function upload(request:URLRequest, uploadDataFieldName:String = "Filedata", testUpload:Boolean = false):void;
	}
}
