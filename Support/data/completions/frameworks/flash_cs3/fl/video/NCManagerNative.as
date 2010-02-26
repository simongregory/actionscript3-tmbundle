package fl.video
{
import flash.net.*;
import flash.events.TimerEvent;
import flash.events.NetStatusEvent;
import flash.utils.Timer;
import flash.utils.getTimer;
public class NCManagerNative extends NCManager implements INCManager
{
		public function get streamLength () : Number;
		public function NCManagerNative ();
		internal function connectRTMP () : Boolean;
		internal function onConnected (p_nc:NetConnection, p_bw:Number) : void;
		internal function connectOnStatus (e:NetStatusEvent) : void;
		internal function reconnectOnStatus (e:NetStatusEvent) : void;
}
}
