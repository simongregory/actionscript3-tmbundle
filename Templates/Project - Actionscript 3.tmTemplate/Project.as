/* AS3
	Copyright ${TM_YEAR} ${TM_FULLNAME}
*/
package {
	
	import flash.events.Event;
	import flash.display.Sprite;
	
	/**
	 *	Main Class for Project.
	 *
	 *	@langversion ActionScript 3.0
	 *	@playerversion Flash 9.0
	 *
	 *	@author ${TM_FULLNAME}
	 *	@since ${TM_DATE}
	 */
	public class ${TM_NEW_FILE_BASENAME} extends Sprite {
		
		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		
		/**
		 *	@constructor
		 */
		public function ${TM_NEW_FILE_BASENAME}(){
			super();
			stage.addEventListener( Event.ENTER_FRAME, initialise );
		}
		
		//--------------------------------------
		//  CLASS CONSTANTS
		//--------------------------------------
		
		//--------------------------------------
		// PRIVATE INSTANCE PROPERTIES
		//--------------------------------------
		
		//--------------------------------------
		// GETTERS/SETTERS
		//--------------------------------------
		
		//--------------------------------------
		// PUBLIC INSTANCE METHODS
		//--------------------------------------
		
		//--------------------------------------
		// PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------

		/**
		 *	Initialise stub.
		 */
		private function initialise( event:Event ) : void
		{			
			stage.removeEventListener( Event.ENTER_FRAME, initialise );
			trace( "Initialised" );
		}
		
	}
	
}
