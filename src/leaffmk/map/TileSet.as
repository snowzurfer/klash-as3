package leaffmk.map 
{
	import flash.display.BitmapData;
	
	/**
	 * Represents one tileset parsed from XML
	 * @author Alberto Taiuti
	 */
	public class TileSet 
	{
		// Variables to store tileset properties
		public var firstgid:uint;
		public var lastgid:uint;
		public var name:String;
		public var tileWidth:uint;
		public var source:String;
		public var tileHeight:uint;
		public var imageWidth:uint;
		public var imageHeight:uint;
		public var bitmapData:BitmapData;
		public var imageWidthTil:uint;
		public var imageHeightTil:uint;
		
		
		/**
		 * The mighty constructor
		 * @param	firstgid
		 * @param	name
		 * @param	tileWidth
		 * @param	tileHeight
		 * @param	source
		 * @param	imageWidth
		 * @param	imageHeight
		 */
		public function TileSet(firstgid:int, name:String, tileWidth:int, tileHeight:int, source:String, imageWidth:int, imageHeight:int) {
			this.firstgid = firstgid;
			this.name = name;
			this.tileWidth = tileWidth;
			this.tileHeight = tileHeight;
			this.source = source;
			this.imageWidth = imageWidth;
			this.imageHeight = imageHeight;
			imageWidthTil = Math.floor(imageWidth / tileWidth);
			imageHeightTil = Math.floor(imageHeight / tileHeight);
			lastgid = imageWidthTil * Math.floor(imageHeight / tileHeight) + firstgid - 1;
		}
		
	}

}