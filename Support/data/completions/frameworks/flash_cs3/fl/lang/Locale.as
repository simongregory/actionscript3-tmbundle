package fl.lang
{
import flash.system.Capabilities;
import flash.xml.*;
import flash.net.*;
import flash.events.*;
public class Locale extends flash.events.EventDispatcher
{
		private static var flaName : String;
		private static var defaultLang : String;
		private static var xmlLang : String;
		private static var xmlMap : Object;
		private static var xmlDoc : XMLDocument;
		private static var stringMap : Object;
		private static var delayedInstanceArray : Array;
		private static var currentXMLMapIndex : Number;
		private static var callback : Function;
		private static var autoReplacement : Boolean;
		private static var currentLang : String;
		private static var stringMapList : Object;
		private static var _xmlLoaded : Boolean;
		public static function get autoReplace () : Boolean;
		public static function set autoReplace (auto:Boolean) : Void;
		public static function get languageCodeArray () : Array;
		public static function get stringIDArray () : Array;
		public static function setFlaName (name:String) : void;
		public static function getDefaultLang () : String;
		public static function setDefaultLang (langCode:String) : void;
		public static function addXMLPath (langCode:String, path:String) : void;
		public static function addDelayedInstance (instance:Object, stringID:String);
		public static function checkXMLStatus () : Boolean;
		public static function setLoadCallback (loadCallback:Function);
		public static function loadString (id:String) : String;
		public static function loadStringEx (stringID:String, languageCode:String) : String;
		public static function setString (stringID:String, languageCode:String, stringValue:String) : void;
		public static function initialize () : void;
		public static function loadLanguageXML (xmlLanguageCode:String, customXmlCompleteCallback:Function =null) : void;
		private static function loadXML (langCode:String);
		private static function onXMLLoad (eventObj:Event);
		private static function parseStringsXML (doc:XMLDocument) : void;
		private static function parseXLiff (node:XMLNode) : void;
		private static function parseFile (node:XMLNode) : void;
		private static function parseBody (node:XMLNode) : void;
		private static function parseTransUnit (node:XMLNode) : void;
		private static function parseSource (node:XMLNode) : String;
		private static function assignDelayedInstances () : void;
}
}
