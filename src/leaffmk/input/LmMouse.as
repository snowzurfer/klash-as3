package leaffmk.input 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * Utility class for checking mouse input
	 * @author Alberto Taiuti
	 */
	public class LmMouse 
	{
		// Position of the mouse
		public static var mousePos:Point = new Point(0, 0);
		
		// Wether it is down
		public static var mouseDown:Boolean = false;
		// Wether the mouse has been clicked
		public static var mouseClicked:Boolean = false;
		
		
		
		/**
		 * The mighty constructor
		 */
		public function LmMouse() {
			// You are useless
		}
		
		/**
		 * Triggered when the mouse is pressed down
		 * @param	e
		 */
		static public function onMouseDown(e:MouseEvent):void {
			mouseDown = true;
		}
		
		/**
		 * Triggered when the mouse moves; updates the position
		 * in the class.
		 * @param	e
		 */
		static public function onMouseMove(e:MouseEvent):void {
			mousePos.x = e.stageX; mousePos.y = e.stageY;
		}
		
		/**
		 * Triggered when the mouse is clicked
		 * @param	e
		 */
		static public function onMouseUp(e:MouseEvent):void {
			mouseDown = false; // No more down
			mouseClicked = true;
		}
		
		/**
		 * Reset the flag, so that when it happens again,
		 * the event can be detected.
		 */
		static public function reset():void {
			mouseClicked = false;
		}
	}

}