package fl.controls
{
import Error;
import fl.controls.ScrollBar;
import fl.controls.ScrollBarDirection;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.events.ScrollEvent;
import flash.events.Event;
import flash.events.TextEvent;
import flash.text.TextField;
public class UIScrollBar extends ScrollBar
{
		protected var _scrollTarget : TextField;
		protected var inEdit : Boolean;
		protected var inScroll : Boolean;
		private static var defaultStyles : Object;
		public function set minScrollPosition (minScrollPosition:Number) : Void;
		public function set maxScrollPosition (maxScrollPosition:Number) : Void;
		public function get scrollTarget () : TextField;
		public function set scrollTarget (target:TextField) : Void;
		public function get scrollTargetName () : String;
		public function set scrollTargetName (target:String) : Void;
		public function get direction () : String;
		public function set direction (dir:String) : Void;
		public static function getStyleDefinition () : Object;
		public function UIScrollBar ();
		public function update () : void;
		protected function draw () : void;
		protected function updateScrollTargetProperties () : void;
		public function setScrollProperties (pageSize:Number, minScrollPosition:Number, maxScrollPosition:Number, pageScrollSize:Number =0) : void;
		public function setScrollPosition (scrollPosition:Number, fireEvent:Boolean =true) : void;
		protected function updateTargetScroll (event:ScrollEvent =null) : void;
		protected function handleTargetChange (event:Event) : void;
		protected function handleTargetScroll (event:Event) : void;
}
}
