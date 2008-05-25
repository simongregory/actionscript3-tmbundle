package flash.ui
{
	import flash.events.EventDispatcher;

	public final class ContextMenuItem extends EventDispatcher
	{
		public var caption:String;
		public var enabled:Boolean;
		public var separatorBefore:Boolean;
		public var visible:Boolean;
		public function ContextMenuItem(caption:String, separatorBefore:Boolean = false, enabled:Boolean = true, visible:Boolean = true);
		public function clone():ContextMenuItem;
	}
}