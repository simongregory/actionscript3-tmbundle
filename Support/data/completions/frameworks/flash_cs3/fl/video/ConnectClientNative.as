package fl.video
{
import flash.net.NetConnection;
public class ConnectClientNative extends ConnectClient
{
		public function ConnectClientNative (owner:NCManager, nc:NetConnection, connIndex:uint =0);
		public function _onbwdone (...rest) : void;
		public function _onbwcheck (...rest) : *;
}
}
