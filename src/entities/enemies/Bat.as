package entities.enemies 
{
	import flash.geom.Rectangle;
	import leaffmk.entities.BasicObject;
	import flash.geom.Point;
	import Constants;
	import entities.enemies.Enemy;
	import graphics.Assets;
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	
	/**
	 * Bat class
	 * @author Alberto Taiuti
	 */
	public class Bat extends Enemy
	{
		
		public function Bat(xPos:int, yPos:int, dir:int) {
			super(xPos, yPos, dir, Constants.ENTITY_BAT);
			
			_boundingBox = new Rectangle(_pos.x - 5, _pos.y - 7, 10, 15);
			
			_moveLeft = true;
			_moveUp = true;
			
			_health = 2;
			
			_score = 15;
		}
		
		override public function initGraphics():void {
			_spriteMovLeftBM = new Assets.batMovLeft();
			_spriteMovRightBM = new Assets.batMovRight();
		}
		
		override protected function _onMovFramesTimerComplete(e:TimerEvent):void {
			super._onMovFramesTimerComplete(e);
			
			// Anim is composed of 2 frames. When it reaches 2 (0,1,2..) then reset
			if (_currentFrame > 1) {
				_currentFrame = 0;
			}
		}
		
		override public function get boundingBox():Rectangle {
			_boundingBox.x = Math.floor(_desPos.x - 5);
			_boundingBox.y = Math.floor(_desPos.y - 7);
			
			
			return _boundingBox;
		}
		
	}

}