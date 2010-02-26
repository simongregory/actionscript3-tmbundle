package fl.video
{
import flash.net.NetConnection;
public class ConnectClient
{
		public var owner : NCManager;
		public var nc : NetConnection;
		public var connIndex : uint;
		public var pending : Boolean;
		public function ConnectClient (owner:NCManager, nc:NetConnection, connIndex:uint =0);
		public function close () : void;
		public function onBWDone (...rest) : void;
		public function onBWCheck (...rest) : Number;
}
}
