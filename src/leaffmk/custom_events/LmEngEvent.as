package leaffmk.custom_events 
{
	import flash.events.Event;
	
	/**
	 * Custom event for handling events to the engine
	 * @author Alberto Taiuti
	 */
	public class LmEngEvent extends Event
	{
		// Event types
		public static const ENT_SPAWN_BULLET:String = "spawnBlt";
		
		// Name of the button which dispatched the event
		//private var _dispatcherName:String;
		
		/**
		 * The mighty constructor
		 * @param	type	Type of event. Should be a mouse event
		 * @param	dispatcherName	Name of the button which dispatched the event
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function LmEngEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=true) {
			super(type, bubbles, cancelable);
			
			//_dispatcherName = dispatcherName;
		}
		
		
	}

}