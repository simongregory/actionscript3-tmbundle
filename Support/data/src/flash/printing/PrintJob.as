package flash.printing
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.printing.PrintJobOptions;
	import flash.events.EventDispatcher;

	public class PrintJob extends EventDispatcher
	{
		public var orientation:String;
		public var pageHeight:int;
		public var pageWidth:int;
		public var paperHeight:int;
		public var paperWidth:int;
		public function PrintJob();
		public function addPage(sprite:Sprite, printArea:Rectangle = null, options:PrintJobOptions = null, frameNum:int = 0):void;
		public function send():void;
		public function start():Boolean;
	}
}