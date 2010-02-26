package fl.livepreview
{
import flash.display.*;
import flash.external.*;
import flash.utils.*;
public class LivePreviewParent extends MovieClip
{
		public var myInstance : DisplayObject;
		public function LivePreviewParent ();
		public function onResize (width:Number, height:Number) : void;
		public function onUpdate (...updateArray:Array) : void;
		private function updateCollection (collDesc:Object, index:String) : void;
}
}
