package fl.containers
{
import fl.containers.BaseScrollPane;
import fl.controls.ScrollBar;
import fl.controls.ScrollPolicy;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.events.ScrollEvent;
import fl.managers.IFocusManagerComponent;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.ProgressEvent;
import flash.geom.Rectangle;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.ui.Keyboard;
public class ScrollPane extends BaseScrollPane implements IFocusManagerComponent
{
		protected var _source : Object;
		protected var _scrollDrag : Boolean;
		protected var contentClip : Sprite;
		protected var loader : Loader;
		protected var xOffset : Number;
		protected var yOffset : Number;
		protected var scrollDragHPos : Number;
		protected var scrollDragVPos : Number;
		protected var currentContent : Object;
		private static var defaultStyles : Object;
		public function get scrollDrag () : Boolean;
		public function set scrollDrag (value:Boolean) : Void;
		public function get percentLoaded () : Number;
		public function get bytesLoaded () : Number;
		public function get bytesTotal () : Number;
		public function get content () : DisplayObject;
		public function get source () : Object;
		public function set source (value:Object) : Void;
		public static function getStyleDefinition () : Object;
		public function ScrollPane ();
		public function refreshPane () : void;
		public function update () : void;
		public function load (request:URLRequest, context:LoaderContext =null) : void;
		protected function setVerticalScrollPosition (scrollPos:Number, fireEvent:Boolean =false) : void;
		protected function setHorizontalScrollPosition (scrollPos:Number, fireEvent:Boolean =false) : void;
		protected function drawLayout () : void;
		protected function onContentLoad (event:Event) : void;
		protected function passEvent (event:Event) : void;
		protected function initLoader () : void;
		protected function handleScroll (event:ScrollEvent) : void;
		protected function doDrag (event:MouseEvent) : void;
		protected function doStartDrag (event:MouseEvent) : void;
		protected function endDrag (event:MouseEvent) : void;
		protected function setScrollDrag () : void;
		protected function draw () : void;
		protected function drawBackground () : void;
		protected function clearContent () : void;
		protected function keyDownHandler (event:KeyboardEvent) : void;
		protected function calculateAvailableHeight () : Number;
		protected function configUI () : void;
}
}
