package leaffmk.custom_events
{
	import flash.events.Event;
	
	/**
	 * Custom event for state changes
	 * @author Alberto Taiuti
	 */
	public class LmStateEvent extends Event 
	{
		// Event types
		public static const CHANGE_STATE:String = "changeState";
		
		// Target state to be set when this event is dispatched
		private var _nextState:int;
		
		// Data which one state wants to pass to the next one
		private var _customData:Array;
		
		public function LmStateEvent(type:String, nextState:int, customData:Array = null, bubbles:Boolean=false, cancelable:Boolean=true) {
			super(type, bubbles, cancelable);
			
			_nextState = nextState;
			
			_customData = customData;
		}
		
		
		public function get nextState():int {
			return _nextState;
		}
		
		public function set nextState(value:int):void {
			_nextState = value;
		}
		
		public function get customData():Array 
		{
			return _customData;
		}
		
		public function set customData(value:Array):void 
		{
			_customData = value;
		}
		
	}

}