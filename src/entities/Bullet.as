package entities 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import leaffmk.entities.BasicObject;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	/**
	 * The bullet shot by the player
	 * @author Alberto Taiuti
	 */
	public class Bullet extends BasicObject
	{
		// Possible directions for bullet
		static public const BULLET_DIR_LEFT:int = 0;
		static public const BULLET_DIR_RIGHT:int = 1;
		
		// Graphics
		protected var _sprite:Bitmap;
		protected var _graphicsPos:Point;
		
		// Timer used to determine when the bullet has to be deleted
		private var _lifeTimer:Timer;
		
		public function Bullet(xPos:int, yPos:int, dir:int) {
			super(xPos, yPos, Constants.ENTITY_BULLET);
			
			_boundingBox = new Rectangle(_pos.x - 1, _pos.y - 1, 2, 2);
			
			if (dir == BULLET_DIR_LEFT) {
				_moveLeft = true;
			}
			else if (dir == BULLET_DIR_RIGHT) {
				_moveRight = true;
			}
			
			_state = Constants.ENT_STATE_MOVING;
			
			_hasWorldCollisions = true;
			
			_maxVelX = Constants.BULLET_VEL;
			
			_graphicsPos = new Point(_pos.x - 1, _pos.y - 1);
			
			_lifeTimer = new Timer(500, 1);
			_lifeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, _onTimerComplete);
			_lifeTimer.start();
			
			initGraphics();
		}
		
		override public function initGraphics():void {
			_sprite = new Bitmap(new BitmapData(2, 2, false, 0xFFFFFF));
		}
		
		
		override public function get boundingBox():Rectangle {
			_boundingBox.x = Math.floor(_desPos.x - 1);
			_boundingBox.y = Math.floor(_desPos.y - 1);
			
			
			return _boundingBox;
		}
		
		private function _onTimerComplete(e:TimerEvent) {
			_lifeTimer.reset();
			_state = Constants.ENT_STATE_DEAD;
		}
		
		override public function update(dt:Number):void {	
			switch(_state) {
				case Constants.ENT_STATE_MOVING: {
						if (_moveLeft) {
							_vel.x = -Constants.BULLET_VEL;
							_facingDir = DIR_LEFT;
						}
						else if (_moveRight) {
							_vel.x = Constants.BULLET_VEL;
							_facingDir = DIR_RIGHT;
						}
						
						// Update anim
						
						break;
					}
					
					
			}
			
			super.update(dt);
		}
		
		override public function render(camOffset:Point):void {
			_graphicsPos.x = (_pos.x - 1) - camOffset.x;
			_graphicsPos.y = (_pos.y - 1) - camOffset.y;
			Main.renderManager.drawObject(_sprite.bitmapData, _graphicsPos.x, _graphicsPos.y);
		}
		
	
		
		/**
		 * Called when the entity is informed of its collision with
		 * another one
		 * @param	eType	type of entity this has collided with
		 */
		override public function onEntCollision(eB:BasicObject):void {
			if (eB.type == Constants.ENTITY_BAT || eB.type == Constants.ENTITY_GHOST
				|| eB.type == Constants.ENTITY_SKELETON) { 
				_state = Constants.ENT_STATE_DEAD;
			}
		}
		
		override public function onTilecollision(tileType:int, tileIndex:int, iR:Rectangle):void {
			_state = Constants.ENT_STATE_DEAD;
		}
		
	}
}

