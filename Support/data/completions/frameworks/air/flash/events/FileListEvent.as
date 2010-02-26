package flash.events {
	public class FileListEvent extends Event {
		public var files:Array;
		public function FileListEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, files:Array = null);
		public static const DIRECTORY_LISTING:String = "directoryListing";
		public static const SELECT_MULTIPLE:String = "selectMultiple";
	}
}
