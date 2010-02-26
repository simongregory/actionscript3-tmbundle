package adobe.utils {
public final class CustomActions {
	public static function get actionsList():Array;
	public static function getActions(name:String):String;
	public static function installActions(name:String, data:String):void;
	public static function uninstallActions(name:String):void;
}
}
