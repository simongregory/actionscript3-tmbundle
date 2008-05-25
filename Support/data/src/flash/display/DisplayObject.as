package flash.display
{
	import flash.accessibility.AccessibilityProperties;
	import flash.display.LoaderInfo;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import flash.display.Stage;
	import flash.geom.Transform;
	import flash.geom.Point;
	import flash.events.EventDispatcher;
	import flash.display.IBitmapDrawable;

	public class DisplayObject extends EventDispatcher implements IBitmapDrawable
	{
	   public var accessibilityProperties:AccessibilityProperties;
	   public var alpha:Number;
	   public var blendMode:String;
	   public var cacheAsBitmap:Boolean;
	   public var filters:Array;
	   public var height:Number;
	   public var loaderInfo:LoaderInfo;
	   public var mask:DisplayObject;
	   public var mouseX:Number;
	   public var mouseY:Number;
	   public var name:String;
	   public var opaqueBackground:Object;
	   public var parent:DisplayObjectContainer;
	   public var root:DisplayObject;
	   public var rotation:Number;
	   public var scale9Grid:Rectangle;
	   public var scaleX:Number;
	   public var scaleY:Number;
	   public var scrollRect:Rectangle;
	   public var stage:Stage;
	   public var transform:Transform;
	   public var visible:Boolean;
	   public var width:Number;
	   public var x:Number;
	   public var y:Number;
	   public function getBounds(targetCoordinateSpace:DisplayObject):Rectangle;
	   public function getRect(targetCoordinateSpace:DisplayObject):Rectangle;
	   public function globalToLocal(point:Point):Point;
	   public function hitTestObject(obj:DisplayObject):Boolean;
	   public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean;
	   public function localToGlobal(point:Point):Point;
	}
}