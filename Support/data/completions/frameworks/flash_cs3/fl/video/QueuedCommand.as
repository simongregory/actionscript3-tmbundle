package fl.video
{
public class QueuedCommand
{
		public static const PLAY : uint;
		public static const LOAD : uint;
		public static const PAUSE : uint;
		public static const STOP : uint;
		public static const SEEK : uint;
		public static const PLAY_WHEN_ENOUGH : uint;
		public var type : uint;
		public var url : String;
		public var isLive : Boolean;
		public var time : Number;
		public function QueuedCommand (type:uint, url:String, isLive:Boolean, time:Number);
}
}
