/* AS3
	Copyright ${TM_YEAR} ${TM_FULLNAME}.
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
	 *	@author ${TM_FULLNAME}
	 *	@since  ${TM_DATE}
	 */
	public class ${TM_NEW_FILE_BASENAME} extends EventDispatcher {
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		//--------------------------------------
		//  SINGLETON CONSTRUCTION
		//--------------------------------------
		
		private static var _instance : ${TM_NEW_FILE_BASENAME};
		
		public static function get instance() : ${TM_NEW_FILE_BASENAME} {
			return initialize();
		}
		
		public static function initialize() : ${TM_NEW_FILE_BASENAME} {
			if (_instance == null){
				_instance = new ${TM_NEW_FILE_BASENAME}();
			}
			return _instance;
		}
		
		/**
		*	ActionScript 3 provides no protection against accidental instantiation of more than 
		* 	one instance as the constructor has to be public.
		*	
		*	@constructor
		*/
		public function ${TM_NEW_FILE_BASENAME}(){
			super();
			if( _instance != null ) throw new Error( "Error:${TM_NEW_FILE_BASENAME} already initialised." );
			if( _instance == null ) _instance = this;
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
