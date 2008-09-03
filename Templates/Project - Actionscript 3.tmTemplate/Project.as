package {

import flash.events.Event;
import flash.display.Sprite;

/**
 *	Application entry point for ${TM_NEW_FILE_BASENAME}.
 *
 *	@langversion ActionScript 3.0
 *	@playerversion Flash 9.0
 *
 *	@author ${TM_FULLNAME}
 *	@since ${TM_DATE}
 */
public class ${TM_NEW_FILE_BASENAME} extends Sprite {
	
	/**
	 *	@constructor
	 */
	public function ${TM_NEW_FILE_BASENAME}()
	{
		super();
		stage.addEventListener( Event.ENTER_FRAME, initialize );
	}

	/**
	 *	Initialize stub.
	 */
	private function initialize(event:Event):void
	{
		stage.removeEventListener( Event.ENTER_FRAME, initialize );
		trace( "${TM_NEW_FILE_BASENAME}::initialize()" );
	}
	
}

}
