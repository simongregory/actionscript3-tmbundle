package fl.video
{
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.events.*;
public class FPADManager
{
		private var _owner : INCManager;
		internal var xml : XML;
		internal var xmlLoader : URLLoader;
		internal var rtmpURL : String;
		internal var _url : String;
		internal var _uriParam : String;
		internal var _parseResults : ParseResults;
		public function FPADManager (owner:INCManager);
		internal function connectXML (urlPrefix:String, uriParam:String, urlSuffix:String, uriParamParseResults:ParseResults) : Boolean;
		internal function xmlLoadEventHandler (e:Event) : void;
}
}
