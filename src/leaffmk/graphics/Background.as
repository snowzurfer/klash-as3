package leaffmk.graphics 
{
	import flash.display.BitmapData;
	import leaffmk.maths.Vector2;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import leaffmk.graphics.BgLayer;
	import leaffmk.Constants;
	
	/**
	 * Represents a background which can be scrolling or not
	 * @author Alberto Taiuti
	 */
	public class Background
	{
		
		// Layers
		private var _bgLayer0:BgLayer;
		private var _bgLayer1:BgLayer;
		private var _bgLayer2:BgLayer;
		private var _bgLayer3:BgLayer;
		
		
		/**
		 * The mighty constructor
		 * @param	scrolling		Wether or not it is scrolling
		 * @param	vel		Velocity
		 * @param	pos		Position
		 * @param	size	Width and height
		 */
		public function Background() {
			_bgLayer0 = new BgLayer(Constants.BGID_SKY, 0.2);
			_bgLayer1 = new BgLayer(Constants.BGID_RIVERSIDE, 0.5);
			_bgLayer2 = new BgLayer(Constants.BGID_RIVERBANK, 1);
			_bgLayer3 = new BgLayer(Constants.BGID_RIVERSIDECLOSE, 1.1);
		}
		
		/**
		 * Load the image 
		 * @param	imgPath
		 */
		public function initGraphics():void {
			_bgLayer0.initGraphics();
			_bgLayer1.initGraphics();
			_bgLayer2.initGraphics();
			_bgLayer3.initGraphics();
		}
		
		public function update(dt:Number, playerXVel:Number):void {
			// Scroll the background
			_bgLayer0.update(dt, playerXVel);
			_bgLayer1.update(dt, playerXVel);
			_bgLayer2.update(dt, playerXVel);
			_bgLayer3.update(dt, playerXVel);
		}
		
	
		
		public function render():void {
			// Render layers
			_bgLayer0.render();
			_bgLayer1.render();
			_bgLayer2.render();
			_bgLayer3.render();
			
		}
		
		
		
	}

}