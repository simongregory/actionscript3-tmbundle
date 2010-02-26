package fl.managers
{
import fl.core.UIComponent;
import flash.display.Sprite;
import flash.text.TextFormat;
import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;
import flash.utils.getQualifiedSuperclassName;
public class StyleManager
{
		private static var _instance : StyleManager;
		private var styleToClassesHash : Object;
		private var classToInstancesDict : Dictionary;
		private var classToStylesDict : Dictionary;
		private var classToDefaultStylesDict : Dictionary;
		private var globalStyles : Object;
		public function StyleManager ();
		private static function getInstance ();
		public static function registerInstance (instance:UIComponent) : void;
		private static function setSharedStyles (instance:UIComponent) : void;
		private static function getSharedStyle (instance:UIComponent, name:String) : Object;
		public static function getComponentStyle (component:Object, name:String) : Object;
		public static function clearComponentStyle (component:Object, name:String) : void;
		public static function setComponentStyle (component:Object, name:String, style:Object) : void;
		private static function getClassDef (component:Object) : Class;
		private static function invalidateStyle (name:String) : void;
		private static function invalidateComponentStyle (componentClass:Class, name:String) : void;
		public static function setStyle (name:String, style:Object) : void;
		public static function clearStyle (name:String) : void;
		public static function getStyle (name:String) : Object;
}
}
