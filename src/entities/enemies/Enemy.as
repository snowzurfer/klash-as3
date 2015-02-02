package entities.enemies 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import leaffmk.entities.BasicObject;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import Constants;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	import graphics.Assets;
	
	
	/**
	 * Basic class for all the enemies in the game
	 * @author Alberto Taiuti
	 */
	public class Enemy extends BasicObject
	{
		// Graphics
		protected var _spriteMovRightBM:Bitmap;
		protected var _spriteMovLeftBM:Bitmap;
		protected var _movFramesTimer:Timer;
		protected var _currentBM:Bitmap;
		protected var _currentFrame:int;
		
		protected var _graphicsPos:Point;
		
		// In which direction does this enemy move (horizontal or vertical)
		protected var _direction:int;
		protected var _moveUp:Boolean;
		protected var _moveDown:Boolean;
		
		// Enemies variables
		public static const ENM_DIR_HORIZONTAL:int = 0;
		public static const ENM_DIR_VERTICAL:int = 1;
		
		protected var _soundClipDeath:Sound;
		protected var _soundChannelDeath:SoundChannel;
		
		protected var _soundHitten
		
		public function Enemy(xPos:int, yPos:int, dir:int, eType:int) {
			super(xPos, yPos, eType);
			
			_graphicsPos = new Point(_pos.x - 8, _pos.y - 8);
			
			_direction = dir;
			
			_state = Constants.ENT_STATE_MOVING;
			
			_hasWorldCollisions = true;
			_applyGravity = false;
			_applyFriction = false;
			
			_maxVelX = Constants.ENEMY_VEL;
			_maxVelJump = Constants.ENEMY_VEL;
			_maxVelFall = Constants.ENEMY_VEL;
			
			_soundClipDeath = (new Assets.hurtAudio()) as Sound;
			//_soundChannel = new SoundChannel();
			
			_timerHurt.addEventListener(TimerEvent.TIMER_COMPLETE, _onHurtComplete);
			//_sprite = new Assets.ghostTestSprite();
			
			_movFramesTimer = new Timer(200);
			_movFramesTimer.addEventListener(TimerEvent.TIMER, _onMovFramesTimerComplete);
			_currentFrame = 0;
		}
		
		
		protected function _onMovFramesTimerComplete(e:TimerEvent):void {
			_currentFrame ++;
		}
		
		override public function update(dt:Number):void {	
			switch(_state) {
				case Constants.ENT_STATE_MOVING: {
					// If the enemy's behaviour is horizontal movement
					if (_direction == ENM_DIR_HORIZONTAL) {
						if (_moveLeft) {
							_vel.x = -Constants.ENEMY_VEL;
							_facingDir = DIR_LEFT;
						}
						else if (_moveRight) {
							_vel.x = Constants.ENEMY_VEL;
							_facingDir = DIR_RIGHT;
						}
					}
					// If the enemy's behaviour is vertical movement
					else if (_direction == ENM_DIR_VERTICAL) {
						if (_moveUp) {
							_vel.y = -Constants.ENEMY_VEL;
							_facingDir = DIR_LEFT;
						}
						else if (_moveDown) {
							_vel.y = Constants.ENEMY_VEL;
							_facingDir = DIR_RIGHT;
						}
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
				case Constants.ENT_STATE_HURT: {
					// If the entity is not trying to move and is affected by friction
					if(_applyFriction == true) {
						// If it was going right
						if (_vel.x > 0) {
							_acc.x = -(Constants.FRICTION);
						}
						// If it was going left
						if (_vel.x < 0) {
							_acc.x = Constants.FRICTION;
						}
						
						// Below a certain range, just stop horizontal moving
						if (_vel.x < 6 && _vel.x > -6) {
							_acc.x = 0;
							_vel.x = 0;
						}
					}
					
					if (_type == Constants.ENTITY_BAT) {
						if (_facingDir  == DIR_RIGHT) {
							_currentBM = _spriteMovRightBM;
							_currentFrame = 0;
						}
						else {
							_currentBM = _spriteMovLeftBM;
							_currentFrame = 1;
						}
					}
					else {
						if (_facingDir  == DIR_RIGHT) {
							_currentBM = _spriteMovRightBM;
							_currentFrame = 0;
						}
						else {
							_currentBM = _spriteMovLeftBM;
							_currentFrame = 2;
						}
					}
					
					
					break;
				}
				case Constants.ENT_STATE_DEAD: {
					
					//Update anim
					
					break;
				}
				
			}
			
			
			
			super.update(dt);
		}
		
		override public function render(camOffset:Point):void {
			_graphicsPos.x = (_pos.x - 8) - camOffset.x;
			_graphicsPos.y = (_pos.y - 8) - camOffset.y;
			
			Main.renderManager.drawObject(_currentBM.bitmapData, _graphicsPos.x, _graphicsPos.y, 
										new Rectangle(_currentFrame * Constants.ENTITY_SIZE_PX, 0, Constants.ENTITY_SIZE_PX, Constants.ENTITY_SIZE_PX));
		}
		
	
		
		/**
		 * Called when the entity is informed of its collision with
		 * another one
		 * @param	eType	type of entity this has collided with
		 */
		override public function onEntCollision(eB:BasicObject):void {
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
				
				
			switch(eB.type) {
				// When an enemy collides with a collider, it will
				// invert its direction of movement
				case Constants.ENTITY_COLLIDER: {
					_changeDir();
					
					break;
				}
				
				case Constants.ENTITY_PLAYER: {
					_changeDir();
					
					break;
				}
				
				// When an enemy gets hitten by a bullet
				case Constants.ENTITY_BULLET: {
					if (_state != Constants.ENT_STATE_HURT) {
						// Change state to hurt
						_prevState = _state;
						_state = Constants.ENT_STATE_HURT;
						
						trace("hurt");
						// Reduce health
						--_health;
						
						_vel.x = _vel.y = 0;
						
						// Start timer
						_timerHurt.start();
						
						
						// Play soun
						_soundClipDeath.play();
						//_changeDir();
					}
					
				}
				
				
			}
		}
		
		private function _onHurtComplete(e:TimerEvent):void {
			// Set back to idle state
			_prevState = _state;
			_state = Constants.ENT_STATE_MOVING;
			_timerHurt.reset();
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
		}
		
		private function _changeDir():void {
			if (_direction == ENM_DIR_HORIZONTAL) {
				if (_moveLeft == true) {
					_moveLeft = false;
					_moveRight = true;
				}
				else if (_moveRight == true) {
					_moveRight = false;
					_moveLeft = true;
				}
			}
			else if (_direction == ENM_DIR_VERTICAL) {
				if (_moveUp == true) {
					_moveUp = false;
					_moveDown = true;
				}
				else if (_moveDown == true) {
					_moveDown = false;
					_moveUp = true;
				}
			}
		}
		
		
		
		public function get moveDown():Boolean 
		{
			return _moveDown;
		}
		
		public function set moveDown(value:Boolean):void 
		{
			_moveDown = value;
		}
		
		public function get moveUp():Boolean 
		{
			return _moveUp;
		}
		
		public function set moveUp(value:Boolean):void 
		{
			_moveUp = value;
		}
		
		public function get direction():int 
		{
			return _direction;
		}
	}

}