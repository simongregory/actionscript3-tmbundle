package fl.video
{
public dynamic class VideoPlayerClient
{
		private var _owner : VideoPlayer;
		public function get owner () : VideoPlayer;
		public function VideoPlayerClient (vp:VideoPlayer);
		public function onMetaData (info:Object, ...rest) : void;
		public function onCuePoint (info:Object, ...rest) : void;
}
}
