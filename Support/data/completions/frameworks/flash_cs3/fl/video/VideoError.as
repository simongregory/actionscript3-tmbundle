package fl.video
{
public class VideoError extends Error
{
		internal static const BASE_ERROR_CODE : uint;
		public static const NO_CONNECTION : uint;
		public static const ILLEGAL_CUE_POINT : uint;
		public static const INVALID_SEEK : uint;
		public static const INVALID_SOURCE : uint;
		public static const INVALID_XML : uint;
		public static const NO_BITRATE_MATCH : uint;
		public static const DELETE_DEFAULT_PLAYER : uint;
		public static const INCMANAGER_CLASS_UNSET : uint;
		public static const NULL_URL_LOAD : uint;
		public static const MISSING_SKIN_STYLE : uint;
		public static const UNSUPPORTED_PROPERTY : uint;
		private var _code : uint;
		internal static const ERROR_MSG : Array;
		public function get code () : uint;
		public function VideoError (errCode:uint, msg:String =null);
}
}
