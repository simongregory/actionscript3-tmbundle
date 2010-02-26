package fl.controls
{
import fl.data.DataProvider;
import fl.controls.listClasses.CellRenderer;
import fl.controls.listClasses.ICellRenderer;
import fl.controls.listClasses.ListData;
import fl.controls.ScrollPolicy;
import fl.controls.SelectableList;
import fl.core.InvalidationType;
import fl.core.UIComponent;
import fl.events.DataChangeType;
import fl.events.DataChangeEvent;
import fl.events.ListEvent;
import fl.events.ScrollEvent;
import fl.managers.IFocusManagerComponent;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.ui.Keyboard;
import flash.utils.Dictionary;
import flash.geom.Rectangle;
public class List extends SelectableList implements IFocusManagerComponent
{
		protected var _rowHeight : Number;
		protected var _cellRenderer : Object;
		protected var _labelField : String;
		protected var _labelFunction : Function;
		protected var _iconField : String;
		protected var _iconFunction : Function;
		private static var defaultStyles : Object;
		public static var createAccessibilityImplementation : Function;
		public function get labelField () : String;
		public function set labelField (value:String) : Void;
		public function get labelFunction () : Function;
		public function set labelFunction (value:Function) : Void;
		public function get iconField () : String;
		public function set iconField (value:String) : Void;
		public function get iconFunction () : Function;
		public function set iconFunction (value:Function) : Void;
		public function get rowCount () : uint;
		public function set rowCount (value:uint) : Void;
		public function get rowHeight () : Number;
		public function set rowHeight (value:Number) : Void;
		public static function getStyleDefinition () : Object;
		public function List ();
		public function scrollToIndex (newCaretIndex:int) : void;
		protected function configUI () : void;
		protected function calculateAvailableHeight () : Number;
		protected function setHorizontalScrollPosition (value:Number, fireEvent:Boolean =false) : void;
		protected function setVerticalScrollPosition (scroll:Number, fireEvent:Boolean =false) : void;
		protected function draw () : void;
		protected function drawList () : void;
		protected function keyDownHandler (event:KeyboardEvent) : void;
		protected function moveSelectionHorizontally (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		protected function moveSelectionVertically (code:uint, shiftKey:Boolean, ctrlKey:Boolean) : void;
		protected function doKeySelection (newCaretIndex:int, shiftKey:Boolean, ctrlKey:Boolean) : void;
		public function itemToLabel (item:Object) : String;
		protected function initializeAccessibility () : void;
}
}
