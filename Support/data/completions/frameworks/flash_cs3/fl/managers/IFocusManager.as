package fl.managers {
import flash.display.InteractiveObject;
import flash.display.Sprite;
import fl.controls.Button;
public interface IFocusManager {
	function get defaultButton():Button;
	function set defaultButton(value:Button):void;
	function get defaultButtonEnabled():Boolean;
	function set defaultButtonEnabled(value:Boolean):void;
	function get nextTabIndex():int;
	function get showFocusIndicator():Boolean;
	function set showFocusIndicator(value:Boolean):void;
	function getFocus():InteractiveObject;
	function setFocus(o:InteractiveObject):void;
	function showFocus():void;
	function hideFocus():void;
	function activate():void;
	function deactivate():void;
	function findFocusManagerComponent(component:InteractiveObject):InteractiveObject;
	function getNextFocusManagerComponent(backward:Boolean=false):InteractiveObject;
}
}
