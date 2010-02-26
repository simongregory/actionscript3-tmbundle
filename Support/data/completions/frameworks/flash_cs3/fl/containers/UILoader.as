package fl.containers
{
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.events.ComponentEvent;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.events.IOErrorEvent;
import flash.events.HTTPStatusEvent;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.utils.ByteArray;
public class UILoader extends UIComponent
{
		protected var _scaleContent : Boolean;
		protected var _autoLoad : Boolean;
		protected var contentInited : Boolean;
		protected var _source : Object;
		protected var loader : Loader;
		protected var _maintainAspectRatio : Boolean;
		protected var contentClip : Sprite;
		private static var defaultStyles : Object;
		public function get autoLoad () : Boolean;
		public function set autoLoad (value:Boolean) : Void;
		public function get scaleContent () : Boolean;
		public function set scaleContent (value:Boolean) : Void;
		public function get maintainAspectRatio () : Boolean;
		public function set maintainAspectRatio (value:Boolean) : Void;
		public function get bytesLoaded () : uint;
		public function get bytesTotal () : uint;
		public function get content () : DisplayObject;
		public function get source () : Object;
		public function set source (value:Object) : Void;
		public function get percentLoaded () : Number;
		public static function getStyleDefinition () : Object;
		public function UILoader ();
		public function setSize (w:Number, h:Number) : void;
		public function loadBytes (bytes:ByteArray, context:LoaderContext = null) : void;
		public function load (request:URLRequest =null, context:LoaderContext = null) : void;
		public function unload () : void;
		public function close () : void;
		protected function _unload (throwError:Boolean =false) : void;
		protected function initLoader () : void;
		protected function handleComplete (event:Event) : void;
		protected function passEvent (event:Event) : void;
		protected function handleError (event:Event) : void;
		protected function handleInit (event:Event) : void;
		protected function clearLoadEvents () : void;
		protected function draw () : void;
		protected function drawLayout () : void;
		protected function sizeContent (target:DisplayObject, contentWidth:Number, contentHeight:Number, targetWidth:Number, targetHeight:Number) : void;
		protected function configUI () : void;
}
}
