package leaffmk.entities 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.utils.Timer;
	import Constants;
	import leaffmk.custom_events.LmEntityEvent;
	
	/**
	 * The very basic object of the leaf framework. Can either be moving or not.
	 * Has properties that each entity/object shares. (So it can either be a rock,
	 * a character, etc).
	 * @author Alberto Taiuti
	 */
	public class BasicObject extends EventDispatcher
	{		
		// Possible facing directions for entity
		static public const DIR_LEFT:int = 0;
		static public const DIR_RIGHT:int = 1;
		
		// Entity's uinque ID
		protected var _ID:int;
		
		// Velocity, position, ecc
		protected var _acc:Point;
		protected var _vel:Point;
		protected var _pos:Point; // Represents the centre
		protected var _desPos:Point;
		protected var _maxVelX:Number;
		protected var _maxVelFall:Number;
		protected var _maxVelJump:Number;
		
		// Whether the entity should move left or right
		protected var _moveLeft:Boolean;
		protected var _moveRight:Boolean;
		
		protected var _onGround:Boolean;
		
		// Type of entity
		protected var _type:int;
		
		// The bounding box for collisions detection; doesn't
		// necessarily represent the size of the sprite
		protected var _boundingBox:Rectangle;
		
		// State of the entity
		protected var _state:int;
		protected var _prevState:int;
		
		// Settings
		protected var _hasWorldCollisions:Boolean;
		protected var _applyGravity:Boolean;
		protected var _applyFriction:Boolean;
		
		// Used to assign a unique ID to 
		static private var _entIDCounter:int = 0;
		
		// Health
		protected var _health:int;
		
		// Timer for certain states and other events
		protected var _timerHurt:Timer;
		
		// Score given when this entity gets eliminated
		protected var _score:int;
		
		// Direction in which the object is facing
		protected var _facingDir:int;
		protected var _prevFac
		
		/**
		 * The mighty constructor
		 */
		public function BasicObject(posX:Number, posY:Number, eType:int) {
			//Initialize to 0 the vel etc by default
			_vel = new Point(0, 0);
			_pos = new Point(posX, posY);
			_acc = new Point(0, 0);
			_desPos = _pos.clone();
			
			_state = Constants.ENT_STATE_IDLE;
			_prevState = _state;
			
			_boundingBox = new Rectangle(_pos.x, _pos.y, Constants.ENTITY_SIZE_PX, Constants.ENTITY_SIZE_PX);
			
			_maxVelFall = 0;
			_maxVelJump = 0;
			_maxVelX = 0;
			
			_hasWorldCollisions = false;
			_applyFriction = false;
			_applyGravity = false;
			
			_ID = _entIDCounter;
			_entIDCounter ++;
			
			_health = 1;
			
			// Subscribe to events
			addEventListener(LmEntityEvent.STATE_CHANGE, _onStateChange);
			
			_type = eType;
			
			_timerHurt = new Timer(700, 1);
			
			_score = 10;
			
			_facingDir = DIR_RIGHT;
		}
		
		public function initGraphics():void {
			
		}
		
		public function onTilecollision(tileType:int, tileIndex:int, iR:Rectangle):void {
			
		}
		
		public function handleInput():void {
			
		}
		
		public function update(dt:Number):void {
			switch(_state) {
				case Constants.ENT_STATE_MOVING: {
					// If the entity is not trying to move and is affected by friction
					if (_moveLeft == false && _moveRight == false && _applyFriction == true) {
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
							
							// Set to idle (if possible of course)
							_prevState = _state;
							_state = Constants.ENT_STATE_IDLE;
						}
					}
					break;
				}
				case Constants.ENT_STATE_IDLE: {
					// If the entity is not trying to move and is affected by friction
					if (_moveLeft == false && _moveRight == false && _applyFriction == true) {
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
							
							// Set to idle (if possible of course)
							_prevState = _state;
							_state = Constants.ENT_STATE_IDLE;
						}
					}
					break;
				}
				case Constants.ENT_STATE_HURT: {
					// If the entity is not trying to move and is affected by friction
					if (_moveLeft == false && _moveRight == false && _applyFriction == true) {
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
							
							// Set to idle (if possible of course)
							_prevState = _state;
							_state = Constants.ENT_STATE_IDLE;
						}
					}
					break;
				}
				case Constants.ENT_STATE_JUMPING: {
					// If the entity is not trying to move and is affected by friction
					if (_moveLeft == false && _moveRight == false && _applyFriction == true) {
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
					
					break;
				}
				
				
			}
			
			
			
			
			// If the object is affected by gravity
			if (_applyGravity) {
				_acc.y = Constants.GRAVITY;
			}
				
			
			// Integrate and obtain veloctity	
			_vel.x += _acc.x * dt;
			_vel.y += _acc.y * dt;
			
			// Cap velocity
			if (_vel.x < -_maxVelX) _vel.x = -_maxVelX;
			if (_vel.x > _maxVelX) _vel.x = _maxVelX;
			if (_vel.y < -_maxVelJump) _vel.y = -_maxVelJump
			if (_vel.y > _maxVelFall) _vel.y = _maxVelFall;
			
			
			// Integrate and obtain desired position
			_desPos.x += _vel.x * dt;
			_desPos.y += _vel.y * dt;
			
			// Alsocheck that the object is within the world's boundaries
			if (boundingBox.x < 0) {
				_desPos.x = boundingBox.x + 4;
			}
			else if (boundingBox.right > Constants.MAP_WIDTH) {
				_desPos.x = boundingBox.right - 4;
			}
			
			// Check health of entity
			if (_health <= 0) {
				_state = Constants.ENT_STATE_DEAD;
			}
			
			//trace("Vx:" + (_vel.x) + " Vy:" + (_vel.y)+" DPX:" + _desPos.x + " DPY:" + _desPos.y);
			
			// Reset accelleration so that the next loop forces
			// can be summed up again
			//_acc.x = 0; _acc.y = 0;
		}
		
		
		
		public function render(camOffset:Point):void {
		
		}
		
		/**
		 * Called when the entity is informed of its collision with
		 * another one
		 * @param	eType	type of entity this has collided with
		 */
		public function onEntCollision(eB:BasicObject):void {
			
		}
		
		
		protected function _onStateChange(e:LmEntityEvent):void {
			
		}
		
		public static function sign(num) {
		  return (num > 0) ? 1 : ((num < 0) ? -1 : 0);
		}
		
		// Getters and setters
		
		public function get pos():Point {
			return _pos;
		}
		
		public function set pos(value:Point):void {
			_pos = value;
		}
		
		
		
		public function get vel():Point {
			return _vel;
		}
		
		public function set vel(value:Point):void {
			_vel = value;
		}
		
		
		public function get boundingBox():Rectangle {
			/*_boundingBox.x = _desPos.x - 4;
			_boundingBox.y = _desPos.y - 7;*/
			
			return _boundingBox;
		}
		
		public function get desPos():Point 
		{
			return _desPos;
		}
		
		public function set desPos(value:Point):void 
		{
			_desPos = value;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function get onGround():Boolean 
		{
			return _onGround;
		}
		
		public function set onGround(value:Boolean):void 
		{
			_onGround = value;
		}
		
		public function get ID():int 
		{
			return _ID;
		}
		
		public function get hasWorldCollisions():Boolean 
		{
			return _hasWorldCollisions;
		}
		
		public function get score():int 
		{
			return _score;
		}
		
		public function get state():int 
		{
			return _state;
		}
		
		public function get facingDir():int 
		{
			return _facingDir;
		}
		
		public function get health():int 
		{
			return _health;
		}
		
		public function set score(value:int):void 
		{
			_score = value;
		}
	}

}