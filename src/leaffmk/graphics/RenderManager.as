package leaffmk.graphics
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.filters.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Constants;
	
	/**
	 * Renders the graphics to the screen
	 * @author Alberto Taiuti
	 */
	public class RenderManager
	{
		// Bitmap to be displayed (added to the displayObject stack)
		private var _bitmap:Bitmap;
		
		// BitmapData used as a buffer; graphics are drawn on
		// it and only "bitmap" is added to the stage
		private var _buffer:BitmapData;
		private var _screenBuffer:BitmapData;
		
		
		// Matrix manipulator
		private var _matrix:Matrix;
		
		// Hold the screen's widht and height for this renderer
		public var STAGE_HEIGHT:int;
		public var STAGE_WIDTH:int;
		
		
		public function RenderManager(stageWidth:int, stageHeight:int) {
			
			// Create the buffers
			_buffer = new BitmapData(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT, false, 0xFFFFFF);
			_screenBuffer = new BitmapData(stageWidth, stageHeight, false, 0xFFFFFF)
			
			// Create the bitmap to be added to the stack (displayObject stack) using the buffer
			_bitmap = new Bitmap(_screenBuffer);
			
			STAGE_HEIGHT = stageHeight;
			STAGE_WIDTH = stageWidth;
			
			trace("RenderManager initialized.");
		}
		
		/**
		 * Draw a sprite onto the buffer.
		 * @param	sprite		Sprite to be drawn
		 * @param	xPos		Xposition of the sprite to be drawn
		 * @param	yPos		Y position of the sprite to be drawn
		 * @param	scaleX		X scaling factor	
		 * @param	scaleY		Y scaling factor
		 * @param	rotn		Angle of rotation
		 */
		public function drawObject(obj:BitmapData, xPos:Number, yPos:Number, sourceRect:Rectangle = null):void {
			if (sourceRect == null) {
				sourceRect = new Rectangle(0, 0, obj.width, obj.height);
			}
			// Render sprite on the buffer
			_buffer.copyPixels(obj, sourceRect, new Point(xPos, yPos));
		}
		
		public function renderBuffer():void {
			// Create a new transf. matrix and transform it
			_matrix = new Matrix();
			_matrix.scale(2, 2);
			
			_screenBuffer.draw(_buffer, _matrix);
		}
		
		/**
		 * Clear the screen with the desired colour
		 * @param	colour
		 */
		public function clearScreen(colour:String):void {
			// Create a new bitmapdata with the desired colour
			_buffer.fillRect(new Rectangle(0, 0, Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT), uint(colour));
		}
		
		
		// Setters and getters
		/*public function get buffer():BitmapData
		{
			return _buffer;
		}
		public function set buffer(value:BitmapData):void
		{
			_buffer = value;
		}*/
		
		public function get bitmap():Bitmap {
			return _bitmap;
		}
		public function set bitmap(value:Bitmap):void {
			_bitmap = value;
		}
		
		
	}

}