package flash.desktop {
	import flash.filesystem.File;
	public final  class Updater {
		public function Updater();
		public function update(airFile:File, version:String):void;
	}
}
