/* AS3
	Copyright ${TM_YEAR} ${TM_USERNAME}.
*/
package ${TM_CLASS_PATH} {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/*
	*	Singleton description.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author ${TM_USERNAME}
	*	@since  ${TM_DATE}
	*/
	public class ${TM_NEW_FILE_BASENAME} extends EventDispatcher {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		//--------------------------------------
		//  SINGLETON CONSTRUCTION
		//--------------------------------------
		
		private static var $instance : ${TM_NEW_FILE_BASENAME};
		
		public static function get instance() : ${TM_NEW_FILE_BASENAME} {
			return initialize();
		}
		
		public static function initialize() : ${TM_NEW_FILE_BASENAME} {
			if ($instance == null){
				$instance = new ${TM_NEW_FILE_BASENAME}();
			}
			return $instance;
		}
		
		/**
		*	ActionScript 3 provides no protection against accidental instantiation of more than 
		* 	one instance as the constructor has to be public.
		*/
		public function ${TM_NEW_FILE_BASENAME}(){
			super();
			if( $instance != null ) throw new Error( "Error:${TM_NEW_FILE_BASENAME} already initialised." );
			if( $instance == null ) $instance = this;
		}
		
		//--------------------------------------
		//  PRIVATE VARIABLES
		//--------------------------------------
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------

		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		
	}

}
