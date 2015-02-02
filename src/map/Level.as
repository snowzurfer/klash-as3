package map
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import entities.collectibles.Chest;
	import entities.collectibles.Coin;
	import entities.collectibles.Diamond;
	import entities.collectibles.GoldenStatue;
	import entities.Collider;
	import entities.enemies.Bat;
	import entities.enemies.Ghost;
	import entities.enemies.Skeleton;
	import entities.Player;
	import XML;
	import flash.net.URLLoader;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.display.BitmapData;
	import graphics.Assets;
	import leaffmk.map.TileCodeEventLoader;
	import leaffmk.map.TileSet;
	import leaffmk.map.Tile;
	import leaffmk.collisions.Collisions;
	import entities.enemies.Enemy;
	import leaffmk.entities.BasicObject;
	import Constants;
	
	/**
	 * Represents one level
	 * @author Alberto Taiuti
	 */
	public class Level extends EventDispatcher
	{
		private var _xmlLoader:URLLoader; // for reading the tmx file
		private var _xml:XML; // for storing the tmx data as xml
		
		// Graphics
		private var _bckLayerBM:Bitmap; // for drawing the map the characters will move over etc
		private var _forLayerBM:Bitmap; // data of an image, for drawing the map that the character will move under
		private var _collLayerBM:Bitmap; // for drawing the collidable part of map
		private var _bckImgBM:Bitmap;
		
		// Level variables
		private var _mapWidthT:uint;
		private var _mapHeightT:uint;
		private var _mapWidth:uint;
		private var _mapHeight:uint;
		private var _tileWidht:uint;
		private var _tileHeight:uint;

		// Store all possible tilesets
		private var _tileSets:Array = new Array();
		
		private var _totalTileSets:uint = 0; // Total number of tilesets available in the level
		private var _tileSetsLoaded:uint = 0; // Number of tilesets actually loaded
		
		// Tiles of the level
		private var _bckGrnTiles:Array = new Array();
		private var _collTiles:Array = new Array();
		private var _forGrnTiles:Array = new Array();
		
		private var _eventLoaders:Array = new Array();
		
		// Store clipping for each tileset
		private var _gidClipPosition:Array = new Array();
		
		private var _bufferBitmap:Bitmap = new Bitmap;
		
		private var _numEntities:int;
		
		/**
		 * Mighty constructor
		 */
		public function Level() {
			_xmlLoad();
		}
		
		
		public function initGraphics():void {
			//_xmlLoad();
		}
		
		/**
		 * Load the map from the .TMX file
		 * @param	e
		 */
		private function _xmlLoad():void {
			// Load general properties of the map
			_xml = new XML(new Assets.mapLevel_0);
			_mapWidthT = _xml.attribute("width");
			_mapHeightT = _xml.attribute("height");
			_tileWidht = _xml.attribute("tilewidth");
			_tileHeight = _xml.attribute("tileheight");
			_mapWidth = _mapWidthT * _tileWidht;
			_mapHeight = -_mapHeightT * _tileHeight;
			
			// Load properties every tileset and their properties
			for each (var tileset:XML in _xml.tileset) {
				var imageWidth:uint = _xml.tileset.image.attribute("width")[_totalTileSets];
				var imageHeight:uint = _xml.tileset.image.attribute("height")[_totalTileSets];
				var firstGid:uint = _xml.tileset.attribute("firstgid")[_totalTileSets];
				var tilesetName:String = _xml.tileset.attribute("name")[_totalTileSets];
				var tileset_tileWidht:uint = _xml.tileset.attribute("tilewidth")[_totalTileSets];
				var tileset_tileHeight:uint = _xml.tileset.attribute("tileheight")[_totalTileSets];
				var tilesetImagePath:String = _xml.tileset.image.attribute("source")[_totalTileSets];
				_tileSets.push(new TileSet(firstGid, tilesetName, tileset_tileWidht, tileset_tileHeight, tilesetImagePath, imageWidth, imageHeight));
				
				
				// Create the array continaing the clippings for the current tileset
				_gidClipPosition[_totalTileSets] = new Array();
				
				// Load the array of gid clipping rectangles (for rendering)				
				for (var r:int = 0; r < _tileSets[_totalTileSets].imageHeightTil; r++) {
					for (var c:int = 0; c < _tileSets[_totalTileSets].imageWidthTil; c++) {
						// The rectangle is in pixels
						_gidClipPosition[_totalTileSets][c + (r * _tileSets[_totalTileSets].imageWidthTil)] = 
									new Rectangle(c * tileset_tileWidht, r * tileset_tileHeight,
												  tileset_tileWidht, tileset_tileHeight);
					}
				}
				
				_tileSets[_totalTileSets].bitmapData = Bitmap(new Assets.tileset_0).bitmapData;
				
				
				// Increase the tilesets counter
				_totalTileSets++;
			}
			
			
			
			
			// Initialize the bitmaps used to render the different layers of the tilemap
			_bckImgBM = new Assets.bgInGame();
			_bckLayerBM = new Assets.bgInGame();
			_forLayerBM = new Bitmap(new BitmapData(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT, true, 0));
			_collLayerBM = new Bitmap(new BitmapData(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT, true, 0));
			
			_numEntities = 0;
		}
		
		
		public function loadTileMapAndEntities(entPool:Vector.<BasicObject>, player:Player):void {
			// Load each layer
			for each (var layer:XML in _xml.layer) {
				// Get layer name
				var layerName:String = layer.attribute("name")[0];
				trace(layerName);
				
				// Get layer collision property
				var layerProperty:String = layer.properties.property.attribute("value");
				
				// Determine wether the layer has got collision with the entities
				var _layerCollision:Boolean = true;
				var layerType:int = 0;
				
				// Load different tile map depending on layer
				switch(layerName) {
					case "foreground": {
						layerType = 1;
						_layerCollision = false;
						trace("loading top layer");
						
						
						var _tilesNumber:uint = 0; // Number of tiles in the layer
						
						// Load every tile in the layer and store it into the respective array
						for each (var tile:XML in layer.data.tile) {
							//Get gid of the current tile	
							var gid:Number = tile.attribute("gid"); 		
							
							// Store the tile in into the relative array of tiles
							_forGrnTiles[_tilesNumber] = gid; 
							
							// Increase counter
							_tilesNumber++;
						}
						break;
					}
					
					case "collidables": {
						trace("loading coll layer");
						
						var _tilesNumber:uint = 0; // Number of tiles in the layer
						
						// Load every tile in the layer and store it into the respective array
						for each (var tile:XML in layer.data.tile) {
							//Get gid of the current tile	
							var gid:Number = tile.attribute("gid"); 		
							
							// Store the tile in into the relative array of tiles
							_collTiles[_tilesNumber] = gid; 
							
							// Increase counter
							_tilesNumber++;
						}
						
						
						break;
					}
					
					case "background": {
						trace("loading background layer");
						
						var _tilesNumber:uint = 0; // Number of tiles in the layer
						
						// Load every tile in the layer and store it into the respective array
						for each (var tile:XML in layer.data.tile) {
							//Get gid of the current tile	
							var gid:Number = tile.attribute("gid"); 		
							
							// Store the tile in into the relative array of tiles
							_bckGrnTiles[_tilesNumber] = gid; 
							
							// Increase counter
							_tilesNumber++;
						}
						
						break;
					}
				}
			}
			
			// Load objects in map
			for each (var objectgroup:XML in _xml.objectgroup) { // For each "layer"(group) of objects
				
				// Get name of the group
				var objectGroupName:String = objectgroup.attribute("name");
				
				// Depending on the kind of objects group
				switch(objectGroupName) {
					case "objects": {
						// Retrieve each object in the list
						for each (var object:XML in objectgroup.object) {
							// Get type of entity
							var entType:String = object.attribute("type");
							
							// Get the position
							var entPos:Point = new Point(object.attribute("x"), object.attribute("y"));
							// The position given in Tiled is topleft, while in-game the entity's position is
							// in the centre; therefore offset it by half the size of the entity
							entPos.offset(8, 8);
							
							// Decide which entity to spawn
							switch(entType) {
								case "player": {
									player.pos = entPos.clone();
									player.desPos = player.pos.clone();
									//player = new Player(entPos.x, entPos.y);
									entPool.push(player);
									break;
								}
								case "ghost": {
									entPool.push(new Ghost(entPos.x, entPos.y));
									++ _numEntities;
									break;
								}
								case "collider": {
									entPool.push(new Collider(entPos.x, entPos.y));
									break;
								}
								case "bat": {
									var _batDir:String = object.properties.property.attribute("value");
									++ _numEntities;
									
									switch(_batDir) {
										case "horizontal": {
											entPool.push(new Bat(entPos.x, entPos.y, Enemy.ENM_DIR_HORIZONTAL));
											break;
										}
										case "vertical": {
											entPool.push(new Bat(entPos.x, entPos.y, Enemy.ENM_DIR_VERTICAL));
											break;
										}
									}
									
									break;
								}
								case "skeleton": {
									entPool.push(new Skeleton(entPos.x, entPos.y));
									++ _numEntities;
									break;
								}
								case "diamond": {
									entPool.push(new Diamond(entPos.x, entPos.y));
									++ _numEntities;
									break;
								}
								case "coin": {
									entPool.push(new Coin(entPos.x, entPos.y));
									++ _numEntities;
									break;
								}
								case "chest": {
									entPool.push(new Chest(entPos.x, entPos.y));
									++ _numEntities;
									break;
								}
								case "golden_skull": {
									entPool.push(new GoldenStatue(entPos.x, entPos.y));	
									++ _numEntities;
									break;
								}
							}
						}
						break;
					}
				default:
					trace("unrecognized object type:", objectGroupName);
				}
			
			}
			
			
		}
		
		
		
		
		
		
		
		/**
		 * Render the background layer
		 * @param	camBox	The rectangle representing the camera
		 */
		public function renderBckLayer(camBox:Rectangle):void {
			// Clear the bitmap
			_bckLayerBM.bitmapData.copyPixels(_bckImgBM.bitmapData, new Rectangle(0, 0, Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT), new Point(0, 0));
			
			// Get cam X pos in logic tiles
			var camTileX:int = camBox.x / _tileSets[0].tileWidth;
		
			// Get cam Y pos in logic tiles
			var camTileY:int = camBox.y / _tileSets[0].tileHeight;
			
			// Get cam end X pos in logic tiles
			var camTileWidth:int = (camBox.right / _tileSets[0].tileWidth) + 1;
			
			// Get cam end Y pos in logic tiles
			var camTileHeight:int = (camBox.bottom / _tileSets[0].tileHeight) + 1;
			
			// Get the tile's position in the array
			var pos:int = 0;
					
			// Get the tile's GID
			var GID:int = 0;
			
			// Position in pixels of the tile
			var posTile:Point;
			
			// For each tile row from start to end of the cam's pos
			for (var r:int = camTileY; r < camTileHeight; r++) {
				// For each tile column in that row
				for(var c:int = camTileX; c < camTileWidth; c ++) {
					// Draw the correspondant tile with respect to the camera's offset
					
					// Get the tile's position in the array
					pos = c + (r * _mapWidthT);
					
					// Get the tile's GID
					GID = _bckGrnTiles[pos];
					
					// Skip empty tiles
					if(GID != 0) {
						// Search for correspondant tileset
						var _currentTileset:TileSet; // The tileset from where the tile is from
						var _currTilesetNum:int = 0; // Index for the aforementioned tileset
						// Use tiles from this tileset (we get the source image from here)
						for each( var _searchedTileset:TileSet in _tileSets) {
							// If the gid is between the first and last of the current tileset
							if (GID >= _searchedTileset.firstgid-1 && GID <= _searchedTileset.lastgid) {
								// we found the right tileset for this gid!
								_currentTileset = _searchedTileset;
								break;
							}
							// Increase counter
							_currTilesetNum ++;
						}
						
						// Set the tile's position relative to the camera's position
						posTile = new Point((c * _tileWidht) - camBox.x, (r * _tileHeight) - camBox.y);
						
						// Copy the tile's pixels onto the bitmapdata of the bottom layer
						_bckLayerBM.bitmapData.copyPixels(_currentTileset.bitmapData, 
															_gidClipPosition[_currTilesetNum][GID - 1],
															posTile, 
															null, null, true);
					}
				}
				
			}
			
			// Render the bitmap
			Main.renderManager.drawObject(_bckLayerBM.bitmapData, 0, 0);
			
		}
		
		public function renderTopLayer(camBox:Rectangle):void {
			// Clear the bitmap
			_forLayerBM.bitmapData.fillRect(new Rectangle(0, 0, Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT), 0);
			
			// Get cam X pos in logic tiles
			var camTileX:int = camBox.x / _tileSets[0].tileWidth;
		
			// Get cam Y pos in logic tiles
			var camTileY:int = camBox.y / _tileSets[0].tileHeight;
			
			// Get cam end X pos in logic tiles
			var camTileWidth:int = (camBox.right / _tileSets[0].tileWidth) + 1;
			
			// Get cam end Y pos in logic tiles
			var camTileHeight:int = (camBox.bottom / _tileSets[0].tileHeight) + 1;
			
			// Get the tile's position in the array
			var pos:int = 0;
					
			// Get the tile's GID
			var GID:int = 0;
			
			// Position in pixels of the tile
			var posTile:Point;
			
			// For each tile row from start to end of the cam's pos
			for (var r:int = camTileY; r < camTileHeight; r++) {
				// For each tile column in that row
				for(var c:int = camTileX; c < camTileWidth; c ++) {
					// Draw the correspondant tile with respect to the camera's offset
					
					// Get the tile's position in the array
					pos = c + (r * _mapWidthT);
					
					// Get the tile's GID
					GID = _forGrnTiles[pos];
					
					// Skip empty tiles
					if(GID != 0) {
						// Search for correspondant tileset
						var _currentTileset:TileSet; // The tileset from where the tile is from
						var _currTilesetNum:int = 0; // Index for the aforementioned tileset
						// Use tiles from this tileset (we get the source image from here)
						for each( var _searchedTileset:TileSet in _tileSets) {
							// If the gid is between the first and last of the current tileset
							if (GID >= _searchedTileset.firstgid-1 && GID <= _searchedTileset.lastgid) {
								// we found the right tileset for this gid!
								_currentTileset = _searchedTileset;
								break;
							}
							// Increase counter
							_currTilesetNum ++;
						}
						
						// Set the tile's position relative to the camera's position
						posTile = new Point((c * _tileWidht) - camBox.x, (r * _tileHeight) - camBox.y);
						
						// Copy the tile's pixels onto the bitmapdata of the bottom layer
						_forLayerBM.bitmapData.copyPixels(_currentTileset.bitmapData, 
																_gidClipPosition[_currTilesetNum][GID - 1],
																posTile, 
																null, null, true);
															
					}
				}
			}
			
			// Render the bitmap
			Main.renderManager.drawObject(_forLayerBM.bitmapData, 0, 0);
		}
		
		public function renderCollLayer(camBox:Rectangle):void {
			// Clear the bitmap
			_collLayerBM.bitmapData.fillRect(new Rectangle(0, 0, Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT), 0);
			
			
			// Get cam X pos in logic tiles
			var camTileX:int = camBox.x / _tileSets[0].tileWidth;
		
			// Get cam Y pos in logic tiles
			var camTileY:int = camBox.y / _tileSets[0].tileHeight;
			
			// Get cam end X pos in logic tiles
			var camTileWidth:int = (camBox.right / _tileSets[0].tileWidth) + 1;
			
			// Get cam end Y pos in logic tiles
			var camTileHeight:int = (camBox.bottom / _tileSets[0].tileHeight) + 1;
			
			// Get the tile's position in the array
			var pos:int = 0;
					
			// Get the tile's GID
			var GID:int = 0;
			
			// Position in pixels of the tile
			var posTile:Point;
			
			// For each tile row from start to end of the cam's pos
			for (var r:int = camTileY; r < camTileHeight; r++) {
				// For each tile column in that row
				for(var c:int = camTileX; c < camTileWidth; c ++) {
					// Draw the correspondant tile with respect to the camera's offset
					
					// Get the tile's position in the array
					pos = c + (r * _mapWidthT);
					
					// Get the tile's GID
					GID = _collTiles[pos];
					
					// Skip empty tiles
					if(GID != 0) {
						// Search for correspondant tileset
						var _currentTileset:TileSet; // The tileset from where the tile is from
						var _currTilesetNum:int = 0; // Index for the aforementioned tileset
						// Use tiles from this tileset (we get the source image from here)
						for each( var _searchedTileset:TileSet in _tileSets) {
							// If the gid is between the first and last of the current tileset
							if (GID >= _searchedTileset.firstgid-1 && GID <= _searchedTileset.lastgid) {
								// we found the right tileset for this gid!
								_currentTileset = _searchedTileset;
								break;
							}
							// Increase counter
							_currTilesetNum ++;
						}
						
						// Set the tile's position relative to the camera's position
						posTile = new Point((c * _tileWidht) - camBox.x, (r * _tileHeight) - camBox.y);
						
						// Copy the tile's pixels onto the bitmapdata of the bottom layer
						_collLayerBM.bitmapData.copyPixels(_currentTileset.bitmapData, 
																_gidClipPosition[_currTilesetNum][GID - 1],
																posTile, 
																null, null, true);
															
					}
				}
			}
			
			// Render the bitmap
			Main.renderManager.drawObject(_collLayerBM.bitmapData, 0, 0);
		}
		
		
		
		
		
		
		
		
		public function get tileHeight():uint 
		{
			return _tileHeight;
		}
		
		public function get mapWidthT():uint 
		{
			return _mapWidthT;
		}
		
		public function get mapHeightT():uint 
		{
			return _mapHeightT;
		}
		
		public function get mapWidth():uint 
		{
			return _mapWidth;
		}
		
		public function get mapHeight():uint 
		{
			return _mapHeight;
		}
		
		public function get collTiles():Array 
		{
			return _collTiles;
		}
		
		public function get numEntities():int 
		{
			return _numEntities;
		}
		
		public function set numEntities(value:int):void 
		{
			_numEntities = value;
		}
	}
}