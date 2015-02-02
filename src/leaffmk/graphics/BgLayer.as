package leaffmk.graphics 
{
	import flash.display.Bitmap;
	import leaffmk.graphics.Assets;
	import leaffmk.maths.Vector2;
	import leaffmk.Constants;
	
	/**
	 * Represent one layer of which the background is composed.
	 * This way parallax effect is achieved.
	 * @author Alberto Taiuti
	 */
	public class BgLayer
	{
		// Graphics
		protected var _img0:Bitmap;
		protected var _img1:Bitmap;
		
		// Layer ID
		protected var _id:int;
		// Value of parallax
		protected var _parallax:Number;
		
		/**
		 * The mighty constructor
		 * @param	layerID 	The layer's id
		 * @param	parallax	Value of parallax
		 */
		public function BgLayer(layerID:int, parallax:Number) {
			_id = layerID;
			_parallax = parallax;
		}
		
		
		/**
		 * Load the image 
		 * @param	bgNum
		 */
		public function initGraphics():void {
			
			switch(_id) {
				case Constants.BGID_SKY: {
					_img0 = new Assets.bgSky();
					_img1 = new Assets.bgSky();
					
					// Set position
					_img0.x = 0; _img0.y = 0;
					_img1.x = _img0.width; _img1.y = _img0.y;
					break;
				}
				case Constants.BGID_RIVERSIDE: {
					_img0 = new Assets.bgRiverside();
					_img1 = new Assets.bgRiverside();
					
					// Set position
					// Set position
					_img0.x = 0; _img0.y = 0;
					_img1.x = _img0.width; _img1.y = _img0.y;
					break;
				}
				case Constants.BGID_RIVERBANK: {
					_img0 = new Assets.bgRiverBank();
					_img1 = new Assets.bgRiverBank();
					
					// Set position
					_img0.x = 0; _img0.y = Constants.GAME_AREA.top;
					_img1.x = _img0.width; _img1.y = _img0.y;
					break;
				}
				case Constants.BGID_RIVERSIDECLOSE: {
					_img0 = new Assets.bgRiversideClose();
					_img1 = new Assets.bgRiversideClose();
					
					// Set position
					_img0.x = 0; _img0.y = Main.renderManager.STAGE_HEIGHT - _img0.height;
					_img1.x = _img0.width; _img1.y = _img0.y;
					break;
				}
			}		
		}
		
		/**
		 * Scroll the layer.
		 * @param	dt	Deltatime
		 * @param	playerXVel	X velocity of the player
		 */
		public function update(dt:Number, playerXVel:Number):void {
			// Scroll the layer
			decBgsPosX(Math.ceil(_parallax * (dt * playerXVel)));
			
			// Check if the layer has to be set back
			if (_img0.x < -_img0.width) {
				_img0.x = 0; _img1.x = _img0.width;
			}
		}
		
	
		
		public function render():void {
			
			// Render backgrouns
			Main.renderManager.drawObject(_img0, _img0.x, _img0.y);
			Main.renderManager.drawObject(_img1, _img1.x, _img1.y);
		}
		
		/**
		 * Decrease the X position of the two images
		 * @param	value	The value to add
		 */
		private function decBgsPosX(value:Number):void {
			_img0.x -= value; _img1.x -= value;
		}
		
	}

}