package fl.video
{
public class CuePointManager
{
		private var _owner : FLVPlayback;
		internal var _metadataLoaded : Boolean;
		internal var _disabledCuePoints : Array;
		internal var _disabledCuePointsByNameOnly : Object;
		internal var _asCuePointIndex : int;
		internal var _asCuePointTolerance : Number;
		internal var _linearSearchTolerance : Number;
		internal var _id : uint;
		internal static const DEFAULT_LINEAR_SEARCH_TOLERANCE : Number;
		internal var allCuePoints : Array;
		internal var asCuePoints : Array;
		internal var flvCuePoints : Array;
		internal var navCuePoints : Array;
		internal var eventCuePoints : Array;
		internal static var cuePointsReplace : Array;
		public function get metadataLoaded () : Boolean;
		public function set playheadUpdateInterval (aTime:Number) : Void;
		public function get id () : uint;
		public function CuePointManager (owner:FLVPlayback, id:uint);
		public function reset () : void;
		public function addASCuePoint (timeOrCuePoint:*, name:String =null, parameters:Object =null) : Object;
		public function removeASCuePoint (timeNameOrCuePoint:*) : Object;
		public function setFLVCuePointEnabled (enabled:Boolean, timeNameOrCuePoint:*) : int;
		public function removeCuePoints (cuePointArray:Array, cuePoint:Object) : Number;
		public function insertCuePoint (insertIndex:int, cuePointArray:Array, cuePoint:Object) : Array;
		public function isFLVCuePointEnabled (timeNameOrCuePoint:*) : Boolean;
		public function dispatchASCuePoints () : void;
		public function resetASCuePointIndex (time:Number) : void;
		public function processFLVCuePoints (metadataCuePoints:Array) : void;
		public function processCuePointsProperty (cuePoints:Array) : void;
		internal function addOrDisable (disable:Boolean, cuePoint:Object) : void;
		internal function unescape (origStr:String) : String;
		internal function getCuePointIndex (cuePointArray:Array, closeIsOK:Boolean, time:Number =NaN, name:String =null, start:int =-1, len:int =-1) : int;
		internal function getNextCuePointIndexWithName (name:String, array:Array, index:int) : int;
		internal static function cuePointCompare (time:Number, name:String, cuePoint:Object) : int;
		internal function getCuePoint (cuePointArray:Array, closeIsOK:Boolean, timeNameOrCuePoint:*) : Object;
		internal function getNextCuePointWithName (cuePoint:Object) : Object;
		internal static function deepCopyObject (obj:Object, recurseLevel:uint =0) : Object;
}
}
