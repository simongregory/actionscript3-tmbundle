package flash.net {
	import flash.events.EventDispatcher;
	public class FileReferenceList extends EventDispatcher {
		public function get fileList():Array;
		public function FileReferenceList();
		public function browse(typeFilter:Array = null):Boolean;
	}
}
