package fl.video
{
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.*;
public class SMILManager
{
		private var _owner : INCManager;
		internal var xml : XML;
		internal var xmlLoader : URLLoader;
		internal var baseURLAttr : Array;
		internal var width : int;
		internal var height : int;
		internal var videoTags : Array;
		private var _url : String;
		public function SMILManager (owner:INCManager);
		internal function connectXML (url:String) : Boolean;
		internal function fixURL (origURL:String) : String;
		internal function xmlLoadEventHandler (e:Event) : void;
		internal function parseHead (parentNode:XML) : void;
		internal function parseLayout (parentNode:XML) : void;
		internal function parseBody (parentNode:XML) : void;
		internal function parseSwitch (parentNode:XML) : void;
		internal function parseVideo (node:XML) : Object;
		internal function parseTime (timeStr:String) : Number;
		internal function checkForIllegalNodes (parentNode:XML, kind:String, legalNodes:Array) : void;
}
}
