//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright ${TM_YEAR} ${TM_ORGANIZATION_NAME:-$TM_FULLNAME}
// 
////////////////////////////////////////////////////////////////////////////////

package ${TM_CLASS_PATH} {

import flash.events.Event;

/**
 *	Event subclass description.
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 9.0
 *
 *	@author ${TM_FULLNAME}
 *	@since  ${TM_DATE}
 */
public class ${TM_NEW_FILE_BASENAME} extends Event {
	
	//--------------------------------------
	// CLASS CONSTANTS
	//--------------------------------------
	
	public static const EVENT_NAME:String = "customEvent";
	
	//--------------------------------------
	//  CONSTRUCTOR
	//--------------------------------------
	
	/**
	 *	@constructor
	 */
	public function ${TM_NEW_FILE_BASENAME}( type:String, bubbles:Boolean=true, cancelable:Boolean=false ){
		super(type, bubbles, cancelable);
	}
	
	//--------------------------------------
	//  GETTER/SETTERS
	//--------------------------------------
	
	//--------------------------------------
	//  PUBLIC METHODS
	//--------------------------------------

	override public function clone() : Event {
		return new ${TM_NEW_FILE_BASENAME}(type, bubbles, cancelable);
	}
	
	//--------------------------------------
	//  EVENT HANDLERS
	//--------------------------------------
	
	//--------------------------------------
	//  PRIVATE VARIABLES
	//--------------------------------------
	
	//--------------------------------------
	//  PRIVATE & PROTECTED INSTANCE METHODS
	//--------------------------------------
	
}

}
