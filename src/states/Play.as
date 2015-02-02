package states
{
	import entities.Bullet;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.net.drm.DRMPlaybackTimeWindow;
	import flash.text.TextFormat;
	import leaffmk.states.BaseState;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import leaffmk.entities.BasicObject;
	import leaffmk.collisions.EntCollsion;
	import leaffmk.collisions.ProcEntCollsion;
	import flash.text.AntiAliasType;
	import entities.Player;
	import leaffmk.input.Keyboard;
	import flash.events.Event;
	import map.Level;
	import leaffmk.maths.Vector2
	import Constants;
	import leaffmk.graphics.LmCamera;
	import leaffmk.custom_events.LmStateEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.Matrix;
	import leaffmk.custom_events.LmEngEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import graphics.Assets;
	
	/**
	 * In-game state
	 * @author Alberto Taiuti
	 */
	public class Play extends BaseState
	{		
		// The player
		private var _player:Player;
		
		// Pool of entities
		private var _entPool:Vector.<BasicObject>;
		
		// Pool of entity collisions
		private var _eCollPool:Vector.<EntCollsion>;
		
		// The level
		private var _level:Level;
		
		// The camera
		private var _cam:LmCamera;
		
		// Background sound
		private var _soundClip:Sound;
		private var _soundChannel:SoundChannel;
		private var _soundTransf:SoundTransform;
		
		// UI elements
		protected var _tfScore:TextField;
		//private var _textMatrix:Matrix = new Matrix(1, 0, 0, 1, 0, 0);
		protected var _tScoreBMD:BitmapData;
		private var _tfLives:TextField;
		private var _tLivesBMD:BitmapData;
		private var _lifeHeartBM:Bitmap;
		private var _UIcompositionBM:BitmapData;
		
		
		
		
		public static function sign(num) {
		  return (num > 0) ? 1 : ((num < 0) ? -1 : 0);
		}
		
		/**
		 * The mighty constructor
		 */
		public function Play() {
			super();
			
			_player = new Player(0, 0);
			//Susbribe for events from the player (could be done for each entity)
			_player.addEventListener(LmEngEvent.ENT_SPAWN_BULLET, _onSpawnBullet);
			
			_entPool = new Vector.<BasicObject>();
			
			_eCollPool = new Vector.<EntCollsion>();
			
			_stateID = Constants.STATE_INGAME;
			
			_level = new Level();
			
			_running = true;
			
			_soundClip = (new Assets.ingameAudio) as Sound;
			_soundChannel = new SoundChannel();
			_soundTransf = new SoundTransform(0.3);
			_soundChannel = _soundClip.play(0, 99999);			
			_soundChannel.soundTransform = _soundTransf;
			
			// UI FORMATTING
			_tfLives = new TextField();
			_tfLives.textColor = 0xFFFFFF;
			_tfLives.background = false;
			_tfLives.alpha = 1.0;
			_tfLives.x = 5;
			_tfLives.y = 5;
			_tfLives.width = 55;
			var _textFormat:TextFormat = new TextFormat("Alagard", 14, 0xFFFFFF, true);
			_tfLives.defaultTextFormat = _textFormat;
			_tfLives.text = "Health:";
			
			_tfScore = new TextField();
			_tfScore.textColor = 0xFFFFFF;
			_tfLives.background = false;
			_tfScore.alpha = 1.0;
			_tfScore.x = 230;
			_tfScore.y = 5;
			var _textFormatB:TextFormat = new TextFormat("Alagard", 14, 0xFFFFFF, true);
			_tfScore.defaultTextFormat = _textFormatB;
			_tfScore.text = "Score:";
			
			
			
		}
		
		/**
		 * Init graphics for all the objects
		 */
		override public function initGraphics():void {
			//_bg0.initGraphics();
			//_player.initGraphics();
			
			_level.loadTileMapAndEntities(_entPool, _player);
			
			for each (var entity:BasicObject in _entPool) {
				entity.initGraphics();
			}
			
			_cam = new LmCamera(0, 0, Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT, _player);
			
			_tLivesBMD = new BitmapData(_tfLives.width, _tfLives.height, true, 0x00000000);
			_tLivesBMD.draw(_tfLives);
			
			_tScoreBMD = new BitmapData(_tfScore.width, _tfScore.height, true, 0x00000000);
			_tScoreBMD.draw(_tfScore);
			
			_lifeHeartBM = new Assets.heartUISprite();
		}
		
		
		
		
		/**
		 * Update the game state
		 * @param	dt	DeltaTime
		 */
		override public function update(dt:Number):void {
			// Update only if not paused
			if (_running) {
				
				// Update entitities
				for each (var entity:BasicObject in _entPool) {
					entity.update(dt);
					
					// Remove dead entities
					if (entity.state == Constants.ENT_STATE_DEAD) {
						// In case it is the player, remove also its reference
						if (entity.type == Constants.ENTITY_PLAYER) {
							
							var arrayToGameOver:Array = new Array();
							arrayToGameOver.push(_player.score);
							
							_player = null;
							// Change state to gameover
							dispatchEvent(new LmStateEvent(LmStateEvent.CHANGE_STATE, Constants.STATE_GAMEOVER, arrayToGameOver));
							
							_soundChannel.stop();
						}
						if (entity.type == Constants.ENTITY_BAT || entity.type == Constants.ENTITY_GHOST
							|| entity.type == Constants.ENTITY_SKELETON) {
							_player.score += entity.score;
						}
						
						if (entity.type != Constants.ENTITY_BULLET) {
							-- _level.numEntities;
						}
						
						
						_entPool.splice(_entPool.indexOf(entity), 1);
					}
				}
				
				// Resolve collisions with map
				for each (var entity:BasicObject in _entPool) {
					_checkAndResolveCollisionsMap(entity, _level.collTiles); 
				}
				
				// Resolve collisions between entities
				// Create array of processed entity collision before actually processing them
				var _procEntPool:Vector.<ProcEntCollsion> = new Vector.<ProcEntCollsion>();
				for each (var entity:BasicObject in _entPool) {
					_checkAndResolveCollisionsEntities(entity, _procEntPool);
					
					// Set position of entity at this point (not pretty, could use another for loop
					// but this way we save CPU cycles
					entity.pos = entity.desPos.clone();
				}
				
				// Update camera
				_cam.update();
				
				// Update UI
				_tfScore.text = "Score: " + _player.score;
				
				/*_text.text = _player.pos.x + "\n" + _player.pos.y;
				_textBMD.draw(_text);*/
				
				// When the player dies or all the collectibles and 
				if (_player.health == 0 || _level.numEntities == 0) {
					var arrayToGameOver:Array = new Array();
					arrayToGameOver.push(_player.score);
					
					// Change state to gameover
					dispatchEvent(new LmStateEvent(LmStateEvent.CHANGE_STATE, Constants.STATE_GAMEOVER, arrayToGameOver));
					
					_soundChannel.stop();
				}
			}
		}
		
		private function _checkAndResolveCollisionsEntities(entA:BasicObject, procEntPool:Vector.<ProcEntCollsion>):void {
			// If the entity being examined is a collectible, no need to check for collisions. The moving entities only have to
			// react to such event
			if (entA.type == Constants.ENTITY_CHEST || entA.type == Constants.ENTITY_COIN || 
				entA.type == Constants.ENTITY_DIAMOND || entA.type == Constants.ENTITY_GOLDENSKULL) {
				return;
			}
			
			
			// Check if the current entity is colliding with any other entity
			for each (var entB:BasicObject in _entPool) {
				// Check that the entity processed is not the one which we want to resolve collisions with
				if (entA != entB) {
					
					// Get unique IDs of the entities
					var _eAObjNum:int = entA.ID;
					var _eBObjNum:int = entB.ID;
					
					
					var _alreadyProcessed:Boolean = false;
					
					// Loop through the already processed entities pool
					for each (var _procColl:ProcEntCollsion in procEntPool) {
						// If they have already been processed this frame
						if((_eAObjNum == _procColl.entAID && _eBObjNum == _procColl.entBID) ||
							(_eBObjNum == _procColl.entAID && _eAObjNum == _procColl.entBID)) {
							// Exit this loop
							_alreadyProcessed = true;
							
							break;
						}
					}
					
					// Just skip this loop if the entities have already been processed
					if(_alreadyProcessed) {
						continue;
					}
					
					
					// Get entity's bounding box. Since its position might change between one collision
					// check and the other, it is necessary to retrieve it every loop
					var eABB:Rectangle = entA.boundingBox.clone();
						
					// Get entity's bounding box. Since its position might change between one collision
					// check and the other, it is necessary to retrieve it every loop
					var eCBB:Rectangle = entB.boundingBox.clone();

					// If the two entities collide
					if (eABB.intersects(eCBB)) {
						
						// Tell entities of the collision between them and let them
						// react accordingly to their properties
						entA.onEntCollision(entB);
						entB.onEntCollision(entA);
						
						// Save that these two unique entities have resolved collisions
						// between each other, so that if B has stored a collision event
						// too, nothing will happen
						var pec:ProcEntCollsion = new ProcEntCollsion(_eAObjNum, _eBObjNum);
						procEntPool.push(pec);
					}
				}
			}
		}
		
		/**
		 * Detect user input
		 */
		override public function handleInput():void {
			if(_player != null) {
				_player.handleInput();
			}
		}
		
		/**
		 * Render objects
		 */
		override public function render():void {
			// Render background
			_level.renderBckLayer(_cam.box);
			
			// Render collidable layer
			_level.renderCollLayer(_cam.box);
			
			// Render entities 
			for each (var entity:BasicObject in _entPool) {
				entity.render(_cam.box.topLeft);
			}
			
			// Render objects in front of player
			_level.renderTopLayer(_cam.box);
			
			// Render UI
			_tScoreBMD.fillRect(new Rectangle(0, 0, _tScoreBMD.width, _tScoreBMD.height), 0x00000000);
			_tScoreBMD.draw(_tfScore);
			Main.renderManager.drawObject(_tScoreBMD, _tfScore.x, _tfScore.y);
			Main.renderManager.drawObject(_tLivesBMD, _tfLives.x, _tfLives.y);
			
			for (var i:int = 0; i < _player.health; i ++) {
				Main.renderManager.drawObject(_lifeHeartBM.bitmapData, (_tfLives.x + _tfLives.width) + 2 + (18 * i), _tfLives.y);
			}
			
		}
		
		private function _checkAndResolveCollisionsMap(e:BasicObject, map:Array):void {
			// Check if this entity has to do collision detection
			if(e.hasWorldCollisions) {
			
				// Checks and settings to perform before the start of the algorithm
				e.onGround = false;
				
				// Create the array containing the tiles surrounding the position
				var surroundingTiles:Array = new Array(9);
				
				// Get position in tiles of the argument
				var tPosX:int = (int(e.pos.x) / Constants.TILE_WIDTH);
				var	tPosY:int = (int(e.pos.y) / Constants.TILE_HEIGHT);
				var col:int = 0;
				var row:int = 0;
				
				
				
				// For the 9 tiles we have to get
				for(var i:int = 0; i < 9; i++) {
					// Calculate current row and column
					col = i % 3;
					row = i / 3;
					
					// Retrieve tile ID and store it
					surroundingTiles[i] = ((tPosX - 1 + col) + (_level.mapWidthT * (tPosY - 1 + row)));
					//trace(map[surroundingTiles[i]]);
				}
				
				//trace("px:" + int(e.pos.x) + " py:" + int(e.pos.y)+ " tpx:" + tPosX +" tpy:"+ tPosY + " p4A:" + map[surroundingTiles[4]]); 
				
				// Sort the tiles differently
				swapPos(surroundingTiles, 0, 7);
				swapPos(surroundingTiles, 2, 3);
				swapPos(surroundingTiles, 3, 5);
				swapPos(surroundingTiles, 4, 7);
				swapPos(surroundingTiles, 7, 8);
				
				// Loop through the 9 surrounding tiles
				for (var i:int = 0; i < 9; i++) {
					
					// If the current tile is actually a solid tile
					if(map[surroundingTiles[i]] != Constants.TILE_NULL && map[surroundingTiles[i]] != undefined) {
						// Get entity's bounding box. Since its position might change between one collision
						// check and the other, it is necessary to retrieve it every loop
						var eBB:Rectangle = e.boundingBox.clone();
						
						// Calculate world position of the tile
						var tileR:Rectangle = new Rectangle (int((surroundingTiles[i] % _level.mapWidthT)) * Constants.TILE_WIDTH,
								int((surroundingTiles[i] / _level.mapWidthT)) * Constants.TILE_HEIGHT,
								Constants.TILE_WIDTH,
								Constants.TILE_HEIGHT);
						
						// In case the tile is a spike tile pointing down
						if (map[surroundingTiles[i]] == Constants.TILE_SPIKES_B) {
							tileR.height -= 5;
						}
						else if (map[surroundingTiles[i]] == Constants.TILE_SPIKES_A || map[surroundingTiles[i]] == Constants.TILE_SPIKES_C
								|| map[surroundingTiles[i]] == Constants.TILE_SPIKES_D) {
							tileR.height -= 5;
							tileR.y += 5;
						}
						
						// If the tile and the entity collide
						if(eBB.intersects(tileR)) {
							// Get intersection rectangle
							var iR:Rectangle = eBB.intersection(tileR);
							
							// Inform the entity
							e.onTilecollision(map[surroundingTiles[i]], i, iR);
						}
					}
				}
			}
		}
	
		/**
		 * Called when the user requests the spawn of a bullet
		 * @param	e
		 */
		private function _onSpawnBullet(e:LmEngEvent):void {
			// Depending on which direction the player is facing to
			if (_player.facingDir == BasicObject.DIR_RIGHT) {
				_entPool.push(new Bullet(_player.pos.x + 8, _player.pos.y + 1, Bullet.BULLET_DIR_RIGHT));
			}
			else if (_player.facingDir == BasicObject.DIR_LEFT) {
				_entPool.push(new Bullet(_player.pos.x - 8, _player.pos.y + 1, Bullet.BULLET_DIR_LEFT));
			}
			
		}
	}
}