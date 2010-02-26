package fl.video
{
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.*;
public class TimedTextManager
{
		internal var owner : FLVPlaybackCaptioning;
		private var flvPlayback : FLVPlayback;
		private var videoPlayerIndex : uint;
		private var limitFormatting : Boolean;
		public var xml : XML;
		public var xmlLoader : URLLoader;
		private var _url : String;
		internal var nameCounter : uint;
		internal var lastCuePoint : Object;
		internal var styleStack : Array;
		internal var definedStyles : Object;
		internal var styleCounter : uint;
		internal var whiteSpacePreserved : Boolean;
		internal var fontTagOpened : Object;
		internal var italicTagOpen : Boolean;
		internal var boldTagOpen : Boolean;
		internal static var CAPTION_LEVEL_ATTRS : Array;
		internal var xmlNamespace : Namespace;
		internal var xmlns : Namespace;
		internal var tts : Namespace;
		internal var ttp : Namespace;
		public function TimedTextManager (owner:FLVPlaybackCaptioning);
		internal function load (url:String) : void;
		internal function xmlLoadEventHandler (e:Event) : void;
		internal function parseHead (parentNode:XML) : void;
		internal function parseStyling (parentNode:XML) : void;
		internal function parseBody (parentNode:XML) : void;
		internal function parseParagraph (parentNode:XML) : void;
		internal function parseSpan (parentNode:XML, cuePoint:Object) : String;
		internal function openFontTag () : String;
		internal function closeFontTags () : String;
		internal function parseStyleAttribute (xmlNode:XML, styleObj:Object) : void;
		internal function parseTTSAttributes (xmlNode:XML, styleObject:Object) : void;
		internal function getStyle () : Object;
		internal function pushStyle (styleObj:Object) : void;
		internal function popStyle () : void;
		internal function copyStyleObjectProps (tgt:Object, src:Object) : void;
		internal function parseColor (colorStr:String) : Object;
		internal function parseFontSize (sizeStr:String) : String;
		internal function parseFontFamily (familyStr:String) : String;
		internal function parseTimeAttribute (parentNode:XML, attr:String, req:Boolean) : Number;
		internal function checkForIllegalElements (parentNode:XML, legalNodes:Object) : void;
		internal function fixCaptionText (inText:String) : String;
		internal function unicodeEscapeReplace (match:String, first:String, second:String, index:int, all:String) : String;
		internal function getSpaceAttribute (node:XML) : String;
}
}
