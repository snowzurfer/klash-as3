package leaffmk.custom_events 
{
	import flash.events.Event;
	
	/**
	 * Custom event to handle custom buttons events
	 * @author Alberto Taiuti
	 */
	public class LmBtnEvent extends Event
	{
		// Event types
		public static const BTN_CLICK:String = "btnClicked";
		
		// Name of the button which dispatched the event
		private var _dispatcherName:String;
		
		/**
		 * The mighty constructor
		 * @param	type	Type of event. Should be a mouse event
		 * @param	dispatcherName	Name of the button which dispatched the event
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function LmBtnEvent(type:String, dispatcherName:String, bubbles:Boolean=false, cancelable:Boolean=true) {
			super(type, bubbles, cancelable);
			
			_dispatcherName = dispatcherName;
		}
		
		
		public function get dispatcherName():String {
			return _dispatcherName;
		}
		
		public function set dispatcherName(value:String):void {
			_dispatcherName = value;
		}
		
	}

}