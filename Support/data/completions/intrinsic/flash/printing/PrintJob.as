package flash.printing {
	import flash.events.EventDispatcher;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	public class PrintJob extends EventDispatcher {
		public function get orientation():String;
		public function get pageHeight():int;
		public function get pageWidth():int;
		public function get paperHeight():int;
		public function get paperWidth():int;
		public function PrintJob();
		public function addPage(sprite:Sprite, printArea:Rectangle = null, options:PrintJobOptions = null, frameNum:int = 0):void;
		public function send():void;
		public function start():Boolean;
	}
}
