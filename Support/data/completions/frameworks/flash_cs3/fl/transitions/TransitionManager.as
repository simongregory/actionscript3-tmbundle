package fl.transitions
{
import flash.events.EventDispatcher;
import flash.display.*;
import flash.geom.Rectangle;
import flash.events.Event;
public class TransitionManager extends EventDispatcher
{
		private static var IDCount : int;
		public var type : Object;
		public var className : String;
		private var _content : MovieClip;
		private var _transitions : Object;
		public var _innerBounds : Rectangle;
		public var _outerBounds : Rectangle;
		public var _width : Number;
		public var _height : Number;
		private var _contentAppearance : Object;
		private var _visualPropList : Object;
		private var _triggerEvent : String;
		public function set content (c:MovieClip) : Void;
		public function get content () : MovieClip;
		public function get transitionsList () : Object;
		public function get numTransitions () : Number;
		public function get numInTransitions () : Number;
		public function get numOutTransitions () : Number;
		public function get contentAppearance () : Object;
		public static function start (content:MovieClip, transParams:Object) : Transition;
		internal function TransitionManager (content:MovieClip);
		public function startTransition (transParams:Object) : Transition;
		public function addTransition (trans:Transition) : Transition;
		public function removeTransition (trans:Transition) : Boolean;
		public function findTransition (transParams:Object) : Transition;
		public function removeAllTransitions () : void;
		public function saveContentAppearance () : void;
		public function restoreContentAppearance () : void;
		internal function transitionInDone (e:Object) : void;
		internal function transitionOutDone (e:Object) : void;
}
}
