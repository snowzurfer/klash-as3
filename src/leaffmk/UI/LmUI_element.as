package leaffmk.UI 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	
	/**
	 * Basic UI element.
	 * @author Alberto Taiuti
	 */
	public class LmUI_element extends EventDispatcher
	{
		// Position and width of the element
		protected var _shape:Rectangle;
		
		protected var _bgColour:uint;
		
		// Is the element visible?
		protected var _visible:Boolean;
		
		// Texture
		protected var _imgBMD:BitmapData;
		protected var _imgBM:Bitmap;
		
		/**
		 * The mighty constructor
		 * @param	x	X pos
		 * @param	y	Y pos
		 * @param	width	Width of the element
		 * @param	height	Height of the element
		 * @param	background	Wether it has a background
		 * @param	bgColour	Colour to fill the background with
		 */
		public function LmUI_element(x:Number = 0, y:Number = 0, width:int = 10, height:int = 10, bgNorm:Class = null) {
			_shape = new Rectangle(x, y, width, height);
			
			_visible = true; // Default: element visible
			
			_imgBM = new bgNorm();
		}
		
		public function update():void {
			
		}
		
		public function render():void {
			// If not visible
			if (!_visible)
				return; // Exit
				
			Main.renderManager.drawObject(_imgBM.bitmapData, _shape.x, _shape.y, _shape);	
		}
		
		
		// Getters and setters
		public function get shape():Rectangle {
			return _shape;
		}
		
		public function set shape(value:Rectangle):void {
			_shape = value;
		}
		
		public function get visible():Boolean {
			return _visible;
		}
		
		public function set visible(value:Boolean):void {
			_visible = value;
		}
		
	}

}