package fl.controls
{
import fl.controls.RadioButton;
import flash.utils.Dictionary;
import flash.events.EventDispatcher;
import flash.events.Event;
public class RadioButtonGroup extends EventDispatcher
{
		private static var groups : Object;
		private static var groupCount : uint;
		protected var _name : String;
		protected var radioButtons : Array;
		protected var _selection : RadioButton;
		public function get name () : String;
		public function get selection () : RadioButton;
		public function set selection (value:RadioButton) : Void;
		public function get selectedData () : Object;
		public function set selectedData (value:Object) : Void;
		public function get numRadioButtons () : int;
		public static function getGroup (name:String) : RadioButtonGroup;
		private static function registerGroup (group:RadioButtonGroup) : void;
		private static function cleanUpGroups () : void;
		public function RadioButtonGroup (name:String);
		public function addRadioButton (radioButton:RadioButton) : void;
		public function removeRadioButton (radioButton:RadioButton) : void;
		public function getRadioButtonIndex (radioButton:RadioButton) : int;
		public function getRadioButtonAt (index:int) : RadioButton;
}
}
