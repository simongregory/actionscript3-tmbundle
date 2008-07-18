package flash.net {
	public function getClassByAlias(aliasName:String):Class;
	public function navigateToURL(request:URLRequest, window:String = null):void;
	public function registerClassAlias(aliasName:String, classObject:Class):void;
	public function sendToURL(request:URLRequest):void;
}
