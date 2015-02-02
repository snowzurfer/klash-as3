package entities.enemies 
{
	import Constants;
	import flash.geom.Rectangle;
	import graphics.Assets;
	import flash.events.TimerEvent;
	
	/**
	 * Skeleton class
	 * @author Alberto Taiuti
	 */
	public class Skeleton extends Enemy
	{
		
		public function Skeleton(xPos:int, yPos:int) {
			super(xPos, yPos, ENM_DIR_HORIZONTAL, Constants.ENTITY_SKELETON);
			
			_boundingBox = new Rectangle(_pos.x - 5, _pos.y - 7, 10, 15);
			
			_moveRight = true;
			
			_health = 3;
			
			_score = 30;
		}
		
		override public function initGraphics():void {
			_spriteMovLeftBM = new Assets.skeletonMovLeft();
			_spriteMovRightBM = new Assets.skeletonMovRight();
		}
		
		
		override protected function _onMovFramesTimerComplete(e:TimerEvent):void {
			super._onMovFramesTimerComplete(e);
			
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
		
		override public function get boundingBox():Rectangle {
			_boundingBox.x = Math.floor(_desPos.x - 5);
			_boundingBox.y = Math.floor(_desPos.y - 7);
			
			
			return _boundingBox;
		}
	}

}