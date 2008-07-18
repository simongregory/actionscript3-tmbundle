package {
	public const Infinity:Number;
	public const NaN:Number;
	public const undefined:*;
	public function decodeURI(uri:String):String;
	public function decodeURIComponent(uri:String):String;
	public function encodeURI(uri:String):String;
	public function encodeURIComponent(uri:String):String;
	public function escape(str:String):String;
	public function isFinite(num:Number):Boolean;
	public function isNaN(num:Number):Boolean;
	public function isXMLName(str:String):Boolean;
	public function parseFloat(str:String):Number;
	public function parseInt(str:String, radix:uint = 0):Number;
	public function trace(... arguments):void;
	public function unescape(str:String):String;
}
