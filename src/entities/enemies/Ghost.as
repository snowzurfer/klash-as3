package entities.enemies 
{
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import leaffmk.entities.BasicObject;
	import flash.geom.Point;
	import Constants;
	import entities.enemies.Enemy;
	import graphics.Assets;
	import flash.display.Bitmap;
	
	/**
	 * Ghost entity class
	 * @author Alberto Taiuti
	 */
	public class Ghost extends Enemy
	{
		
		public function Ghost(xPos:int, yPos:int) {
			super(xPos, yPos, ENM_DIR_HORIZONTAL, Constants.ENTITY_GHOST);
			
			_boundingBox = new Rectangle(_pos.x - 7, _pos.y - 5, 14, 10);
			
			_moveLeft = true;
			
			_health = 2;
			
			_score = 20;
		}
		
		override public function initGraphics():void {
			_spriteMovLeftBM = new Assets.ghostMovLeft();
			_spriteMovRightBM = new Assets.ghostMovRight();
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
			_boundingBox.x = Math.floor(_desPos.x - 7);
			_boundingBox.y = Math.floor(_desPos.y - 5);
			
			
			return _boundingBox;
		}
	}

}