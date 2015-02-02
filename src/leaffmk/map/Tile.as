package leaffmk.map 
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	/**
	 * Single tile for tiled map engine
	 * @author Alberto Taiuti
	 */
	public class Tile 
	{
		// Graphics
		// Associate the type of tile to a section of the source image
		
		// Position and shape
		private var _box:Rectangle;
		
		// Graphical ID, unique
		private var _gid:int;
		
		// Type of tyle
		private var _type:int;
		
		// Tileset for this tile
		private var _tileset:int;
		
		public function Tile(xPos:Number, yPos:Number, w:Number, h:Number, gid:int, tileset:int, type:int) {
			_box = new Rectangle(xPos, yPos, w, h);
			_gid = gid;
			_type = type;
		}
		
		public function initGraphics():void {
			
		}
		
		/**
		 * Render tile
		 */
		public function render():void {
			
		}
		
		public function get box():Rectangle 
		{
			return _box;
		}
		
		public function set box(value:Rectangle):void 
		{
			_box = value;
		}
		
		public function get gid():int 
		{
			return _gid;
		}
		
		public function set gid(value:int):void 
		{
			_gid = value;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
		}
		
		public function get tileset():int 
		{
			return _tileset;
		}
		
		public function set tileset(value:int):void 
		{
			_tileset = value;
		}
		
	}

}