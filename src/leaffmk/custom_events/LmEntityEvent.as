package leaffmk.custom_events 
{
	import flash.events.Event;
	/**
	 * Events triggered by the entities
	 * @author Alberto Taiuti
	 */
	public class LmEntityEvent extends Event
	{
		
		// Event types
		public static const STATE_CHANGE:String = "stateChange";
		
		// ID of the current state
		private var _currentState:int;
		// ID of the state the entity wants to set
		private var _nextState:int;
		
		/**
		 * The mighty constructor
		 * @param	type
		 * @param	currentState
		 * @param	nextState
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function LmEntityEvent(type:String, currentState:int, nextState:int, bubbles:Boolean=false, cancelable:Boolean=true) {
			super(type, bubbles, cancelable);
			
			_currentState = currentState;
			_nextState = nextState;
		}
		
		
		
		public function get currentState():int 
		{
			return _currentState;
		}
		
		public function get nextState():int 
		{
			return _nextState;
		}
		
	}

}