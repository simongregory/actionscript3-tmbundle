package flash.utils {
	public namespace flash_proxy;
	public function clearInterval(id:uint):void;
	public function clearTimeout(id:uint):void;
	public function describeType(value:*):XML;
	public function escapeMultiByte(value:String):String;
	public function getDefinitionByName(name:String):Object;
	public function getQualifiedClassName(value:*):String;
	public function getQualifiedSuperclassName(value:*):String;
	public function getTimer():int;
	public function setInterval(closure:Function, delay:Number, ... arguments):uint;
	public function setTimeout(closure:Function, delay:Number, ... arguments):uint;
	public function unescapeMultiByte(value:String):String;
}
