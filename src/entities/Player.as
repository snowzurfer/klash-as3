package entities 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import leaffmk.entities.BasicObject;
	import graphics.Assets;
	import leaffmk.input.Keyboard;
	import Constants;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import leaffmk.custom_events.LmEntityEvent;
	import leaffmk.custom_events.LmEngEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	
	/**
	 * Player class
	 * @author Alberto Taiuti
	 */
	public class Player extends BasicObject
	{	
		// Graphics
		private var _spriteMovRightBM:Bitmap;
		private var _spriteMovLeftBM:Bitmap;
		private var _spriteShootRightBM:Bitmap;
		private var _spriteShootLeftBM:Bitmap;
		private var _movFramesTimer:Timer;
		private var _currentBM:Bitmap;
		private var _currentFrame:int;
		
		private var _graphicsPos:Point;
		
		private var _shoot:Boolean;
		private var _shot:Boolean;
		
		// Player's private behaviours
		private var _jump:Boolean;
		private var _jumpCutoff:int;
		
		// Timer triggered when the player is shooting
		protected var _timerShoot:Timer;
		
		protected var _soundClipHurt:Sound;
		protected var _soundClipShoot:Sound;
		protected var _soundClipJump:Sound;
		protected var _soundChannelShoot:SoundChannel;
		protected var _soundChannelHurt:SoundChannel;
		protected var _soundChannelJump:SoundChannel;
		
		/**
		 * Mighty constructor
		 */
		public function Player(xPos:int, yPos:int) {
			
			super(xPos, yPos, Constants.ENTITY_PLAYER);
			
			_maxVelFall = Constants.MAX_DY_DOWN;
			_maxVelJump = Constants.MAX_DY_UP;
			_maxVelX = Constants.MAX_DX;
			
			_graphicsPos = new Point (_pos.x - 8, _pos.y - 8);
			
			_hasWorldCollisions = true;
			_applyGravity = true;
			_applyFriction = true;
			
			_jump = false;
			_jumpCutoff = Constants.JUMP_CUTOFF;
			
			_health = 3;
			
			_boundingBox = new Rectangle(_pos.x - 5, _pos.y - 7, 9, 15);
			
			_timerShoot = new Timer(170, 1);
			_timerShoot.addEventListener(TimerEvent.TIMER_COMPLETE, _onShootComplete);
			_timerHurt = new Timer(1200, 1);
			_timerHurt.addEventListener(TimerEvent.TIMER_COMPLETE, _onHurtComplete);
			
			_score = 0;
			
			_shot = false;
			
			_soundClipHurt = (new Assets.hurtAudio) as Sound;
			_soundClipJump = (new Assets.jumpAudio) as Sound;
			_soundClipShoot = (new Assets.shootAudio) as Sound;
			
			_movFramesTimer = new Timer(80);
			_movFramesTimer.addEventListener(TimerEvent.TIMER, _onMovFramesTimerComplete);
			_currentFrame = 0;
			//_soundChannel = new SoundChannel();
			
			
			//_box = new Rectangle(_pos.x + 3, _pos.y, _spritwidth - 3, _spritheight);
		}
		
		override public function initGraphics():void {
			_spriteMovLeftBM = new Assets.playerMovLeft();
			_spriteMovRightBM = new Assets.playerMovRight();
			_spriteShootLeftBM = new Assets.playerShootLeft();
			_spriteShootRightBM = new Assets.playerShootRight();
			_currentBM = _spriteMovRightBM;
		}
		
		private function _onMovFramesTimerComplete(e:TimerEvent):void {
			_currentFrame ++;
			
			// Anim is composed of 2 frames. When it reaches 2 (0,1,2..) then reset
			if (_facingDir == DIR_LEFT) {
				if (_currentFrame > 1) {
				_currentFrame = 0;
				}
			}
			else if (_facingDir == DIR_RIGHT) {
				if (_currentFrame > 2) {
					_currentFrame = 1;
				}
			}
		}
		
		override public function handleInput():void {
			
			if (Keyboard.isDown(Keyboard.RIGHT)) {
				_moveRight = true;
				_facingDir = DIR_RIGHT;
			}
			else {
				_moveRight = false;
			}
			
			if (Keyboard.isDown(Keyboard.LEFT)) {
				_moveLeft = true;
				_facingDir = DIR_LEFT;
			}
			else {
				_moveLeft = false;
			}
			
			if (Keyboard.isDown(Keyboard.X)) {
				_jump = true;
				
			}
			else {
				_jump = false;
			}
			
			if (Keyboard.isJustPressed(Keyboard.C)) {
				_shoot = true;
			}
			else {
				_shoot = false;
			}
		}
		
		override public function update(dt:Number):void {
			switch(_state) {
				case Constants.ENT_STATE_MOVING: {
					// If the entity wants to jump
					if (_jump) {
						_prevState = _state;
						_state = Constants.ENT_STATE_JUMPING;
						
						_movFramesTimer.reset();
					}
					else if (_shoot) {
						_prevState = _state;
						_state = Constants.ENT_STATE_SHOOTING;
						
						_movFramesTimer.reset();
					}
					
					if (_moveLeft && _moveRight) {
						// do nothing
					}
					else if (_moveLeft) {
						_acc.x = -Constants.ACCEL;
					}
					else if (_moveRight) {
						_acc.x = Constants.ACCEL;
					}
					
					// Update anim
					
					// If the timer is not running
					if (!_movFramesTimer.running) {
						// Start it
						_movFramesTimer.start();
					}
					
					//_currentFrame = 1;
					if (_facingDir  == DIR_RIGHT) {
						_currentBM = _spriteMovRightBM;
					}
					else {
						_currentBM = _spriteMovLeftBM;
					}
					
					
					break;
				}
				case Constants.ENT_STATE_IDLE: {
					_movFramesTimer.reset();
					
					if (_moveLeft || _moveRight) {
						_prevState = _state;
						_state = Constants.ENT_STATE_MOVING;
					}
					
					if (_jump && _onGround) {
						_prevState = _state;
						_state = Constants.ENT_STATE_JUMPING;
						
						_currentFrame = 1;
						if (_facingDir  == DIR_RIGHT) {
							_currentBM = _spriteMovRightBM;
						}
						else {
							_currentBM = _spriteMovLeftBM;
						}
					}
					else if (_shoot) {
						_prevState = _state;
						_state = Constants.ENT_STATE_SHOOTING;
						
						_currentFrame = 0;
						if (_facingDir  == DIR_RIGHT) {
							_currentBM = _spriteShootRightBM;
						}
						else {
							_currentBM = _spriteShootLeftBM;
						}
					}
					
					// Update anim
					
					if (_facingDir  == DIR_RIGHT) {
						_currentBM = _spriteMovRightBM;
						_currentFrame = 0;
					}
					else {
						_currentBM = _spriteMovLeftBM;
						_currentFrame = 2;
					}
					
					
					break;
				}
				case Constants.ENT_STATE_JUMPING: {
					// If the entity wants to jump
					if (_jump && _onGround) {
						_vel.y -= Constants.JUMP_ACC;
						_soundClipJump.play();
					}
					// Otherwise, if the player releases the jump btn while 
					// the entitiy is in air jumping, reduce the jump for
					// giving a sense of control
					else if (!_jump && _vel.y < -_jumpCutoff) {
						_vel.y = -_jumpCutoff;
					}
					// If the entity gets back on the ground
					else if (_onGround) {
						// Set either to idle or moving
						if (sign(_vel.x) != 0) {
							_prevState = _state;
							_state = Constants.ENT_STATE_MOVING;
						}
						else {
							_prevState = _state;
							_state = Constants.ENT_STATE_IDLE;
						}
					}
					
					if (_moveLeft && _moveRight) {
						// do nothing
					}
					else if (_moveLeft) {
						_acc.x = -Constants.ACCEL;
					}
					else if (_moveRight) {
						_acc.x = Constants.ACCEL;
					}
					
					if (_shoot) {
						_prevState = _state;
						_state = Constants.ENT_STATE_SHOOTING;
					}
					
					// Update anim
					_currentFrame = 1;
					if (_facingDir  == DIR_RIGHT) {
						_currentBM = _spriteMovRightBM;
					}
					else {
						_currentBM = _spriteMovLeftBM;
					}
					
					break;
				}
				case Constants.ENT_STATE_SHOOTING: {
					if (!_shot) {
						// Shoot the bullet
						dispatchEvent(new LmEngEvent(LmEngEvent.ENT_SPAWN_BULLET));
						
						// Set the flag to true
						_shot = true;
						
						// If not while jumping
						if (!_onGround) {
							// Stop the player
							_vel.x = 0;
							_acc.x = 0;
						}
						
						
						// Start timer
						_timerShoot.start();
						
						_soundClipShoot.play();
						
						_currentFrame = 0;
						if (_facingDir  == DIR_RIGHT) {
							_currentBM = _spriteShootRightBM;
						}
						else {
							_currentBM = _spriteShootLeftBM;
						}
					}
					
					// Update anim
					
					break;
				}
				case Constants.ENT_STATE_HURT: {
					// If the entity wants to jump
					if (_jump && _onGround) {
						_vel.y -= Constants.JUMP_ACC;
						_soundClipJump.play();
						
						_currentFrame = 1;
						if (_facingDir  == DIR_RIGHT) {
							_currentBM = _spriteMovRightBM;
						}
						else {
							_currentBM = _spriteMovLeftBM;
						}
					}
					// Otherwise, if the player releases the jump btn while 
					// the entitiy is in air jumping, reduce the jump for
					// giving a sense of control
					else if (!_jump && _vel.y < -_jumpCutoff) {
						_vel.y = -_jumpCutoff;
					}
					
					if (_moveLeft && _moveRight) {
						// do nothing
					}
					else if (_moveLeft) {
						_acc.x = -Constants.ACCEL;
					}
					else if (_moveRight) {
						_acc.x = Constants.ACCEL;
					}
					// Update anim
					
					break;
				}
				case Constants.ENT_STATE_DEAD: {
					
					break;
				}
				
			}
			
			super.update(dt);
		}
		
		/**
		 * Render the player
		 */
		override public function render(camOffset:Point):void {
			// Update the position of the graphics with respect to the
			// entity's centre
			_graphicsPos.x = (_pos.x - 8) - camOffset.x;
			_graphicsPos.y = (_pos.y - 8) - camOffset.y;
			
			if(_state == Constants.ENT_STATE_HURT) {
				if(_timerHurt.currentCount%2000 == 0) { // flicker while recovering from damage
				  return;
				}
			}
			
			Main.renderManager.drawObject(_currentBM.bitmapData, _graphicsPos.x, _graphicsPos.y, 
										new Rectangle(_currentFrame * Constants.ENTITY_SIZE_PX, 0, Constants.ENTITY_SIZE_PX, Constants.ENTITY_SIZE_PX));
			/*Main.renderManager.drawObject(new BitmapData(_boundingBox.width, _boundingBox.height, true, 0x33FF0000), _boundingBox.x - camOffset.x, 
											_boundingBox.y- camOffset.y);
			Main.renderManager.drawObject(new BitmapData(1, 1, true, 0xFFFF0000),_pos.x- camOffset.x, 
											_pos.y- camOffset.y);*/
		}
		
		override public function get boundingBox():Rectangle {
			_boundingBox.x = Math.floor(_desPos.x - 4);
			_boundingBox.y = Math.floor(_desPos.y - 7);
			
			
			return _boundingBox;
		} 
		
		
		
		/*override protected function _onStateChange(e:LmEntityEvent) {
			// Depending on which is the current state
			switch(currentState) {
				case Constants
			}
		}*/
		
		/**
		 * Called when the entity is informed of its collision with
		 * another one
		 * @param	eB.type	type of entity this has collided with
		 */
		override public function onEntCollision(eB:BasicObject):void {
			if (eB.type == Constants.ENTITY_BAT || eB.type == Constants.ENTITY_GHOST
				|| eB.type == Constants.ENTITY_SKELETON) {
				
				// Get entity's bounding box. Since its position might change between one collision
				// check and the other, it is necessary to retrieve it every loop
				var eABB:Rectangle = boundingBox.clone();
					
				// Get entity's bounding box. Since its position might change between one collision
				// check and the other, it is necessary to retrieve it every loop
				var eBBB:Rectangle = eB.boundingBox.clone();
				
				// Get the sign of the velocity of the entity being checked
				var xVelSigNum:int = sign(_vel.x);
				var yVelSigNum:int = sign(_vel.y);
				
				// Get intersection rectangle
				var iR:Rectangle = eABB.intersection(eBBB);
				
				// Calculate new desired position of the entity
				var xPos:Number = _desPos.x - (iR.width * xVelSigNum);
				var yPos:Number = _desPos.y - (iR.height * yVelSigNum);
				
				// If the intersection rectangle is wider than taller
				if(iR.width > iR.height) { 
					// Resolve vertically					
					_desPos.y = _pos.y;
				}
				// If the intersection rectangle is taller than wider
				else {
					// Resolve horizontally							
					_desPos.x = _pos.x;
				}	
				
				
				// Set the hurt state
				if (_state == Constants.ENT_STATE_IDLE || _state == Constants.ENT_STATE_MOVING  ||
					_state == Constants.ENT_STATE_JUMPING || _state == Constants.ENT_STATE_SHOOTING) {
					// Reduce health
					-- _health;
					
					// Change animation
	
					
					// Get the enemy's signum, for applying a force to the player when he gets hit
					var _enXVelSigNum:int = sign(eB.vel.x);
					//var _enYVelSigNum:int = sign(eB.vel.y);
					
					// If the enemy was going left
					if (_enXVelSigNum < 0) {
						// Apply force to the left
						_vel.x = -Constants.HURT_IMPULSE_X;
						_vel.y = -Constants.HURT_IMPULSE_Y;
					}
					// If the enemy was going right
					else if (_enXVelSigNum > 0) {
						// Apply force to the right
						_vel.x = Constants.HURT_IMPULSE_X;
						_vel.y = -Constants.HURT_IMPULSE_Y;
					}
					
					// Change state
					_prevState = _state;
					_state = Constants.ENT_STATE_HURT;
					
					// Start timer
					_timerHurt.start();
					
					// Play sound
					_soundClipHurt.play();
				}
			}
			
			if (eB.type == Constants.ENTITY_COIN ||  eB.type == Constants.ENTITY_GOLDENSKULL || 
				 eB.type == Constants.ENTITY_DIAMOND ||  eB.type == Constants.ENTITY_CHEST) {
					
				// Add score to player's score
				_score += eB.score;
			}
		}
		
		private function _onHurtComplete(e:TimerEvent):void {
			// Set back to idle state
			_prevState = _state;
			_state = Constants.ENT_STATE_IDLE;
			_timerHurt.reset();
		}
		
		private function _onShootComplete(e:TimerEvent):void {
			_prevState = _state;
			_state = Constants.ENT_STATE_IDLE;
			_timerShoot.reset();
			
			// Reset the flag
			_shot = false;
		}
		
		override public function onTilecollision(tileType:int, tileIndex:int, iR:Rectangle):void {
			// Act differently depending on the index of tile being computed
			switch(tileIndex) {
				case 0: { // Tile beneath the entity
					desPos = new Point(desPos.x, desPos.y - iR.height);
					vel = new Point(vel.x, 0);
					onGround = true;
					break;
				}
				case 1: { // Tile above entity
					desPos = new Point(desPos.x, desPos.y + iR.height);
					vel = new Point(vel.x, 0);
					break;
				}
				case 2: { // Tile left of entity
					desPos = new Point(desPos.x + iR.width, desPos.y);
					vel = new Point(0 , vel.y);
					break;
				}
				case 3: { // Tile right of entity
					desPos = new Point(desPos.x - iR.width, desPos.y);
					vel = new Point(0 , vel.y);
					break;
				}
				default: { // Handle diagonal tiles cases separately
					// If the intersection rectangle is wider than taller
					if(iR.width > iR.height) { 
						// Resolve vertically
						vel = new Point(vel.x, 0);
						
						// If the tile is beneath the entity
						if(tileIndex > 5) {
							desPos = new Point(desPos.x, desPos.y - iR.height);
							onGround = true;
						}
						// If the tile is above the entity
						else {
							desPos = new Point(desPos.x, desPos.y + iR.height);
						}
					}
					// If the intersection rectangle is taller than wider
					else {
						// Resolve horizontally
						
						// If the tile is left to the entity
						if(tileIndex == 6 || tileIndex == 4){
							desPos = new Point(desPos.x + iR.width, desPos.y);
						}
						// If the tile is right to the entity
						else {
							desPos = new Point(desPos.x - iR.width, desPos.y);
						}
					}
				}
			}
			
			// In case they are spikes, hurt the player
			if (tileType == Constants.TILE_SPIKES_A || tileType == Constants.TILE_SPIKES_B ||
				tileType == Constants.TILE_SPIKES_C || tileType == Constants.TILE_SPIKES_D) {
				if(_state != Constants.ENT_STATE_HURT) {
					
					// Decrease health
					--_health;
					
					if(_onGround) {
						// Get the entity's signum, for applying a force to the player when he gets hit
						var _XVelSigNum:int = sign(_vel.x);
						//var _enYVelSigNum:int = sign(eB.vel.y);
						
						// If the player was going left
						if (_XVelSigNum < 0) {
							// Apply force to the right
							_vel.x = Constants.HURT_IMPULSE_X;
							_vel.y = -Constants.HURT_IMPULSE_Y;
						}
						// If the player was going right
						else if (_XVelSigNum > 0) {
							// Apply force to the left
							_vel.x = -Constants.HURT_IMPULSE_X;
							_vel.y = -Constants.HURT_IMPULSE_Y;
						}
						
					}
				
					// Change state
					_prevState = _state;
					_state = Constants.ENT_STATE_HURT;
					
					// Start timer
					_timerHurt.start();
				}
			}
		}
	}
}