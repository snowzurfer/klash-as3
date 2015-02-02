package entities.collectibles 
{
	import leaffmk.entities.BasicObject;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import Constants;
	import graphics.Assets;
	import flash.geom.Rectangle;
	import entities.collectibles.Collectible;
	import flash.media.Sound;
	
	/**
	 * Represents a collectible item
	 * @author Alberto Taiuti
	 */
	public class Collectible extends BasicObject
	{
		// Graphics
		protected var _sprite:Bitmap;
		protected var _graphicsPos:Point;
		
		protected var _soundClipCollect:Sound;
		
		public function Collectible(xPos:int, yPos:int, eType:int) {
			super(xPos, yPos, eType);
			
			_graphicsPos = new Point(_pos.x - 8, _pos.y - 8);
		}
		
		override public function initGraphics():void {
		}
		
		
		
		override public function onEntCollision(eB:BasicObject):void {
			if (eB.type == Constants.ENTITY_PLAYER) {
				// Play sound
				
				// Delete entity
				_state = Constants.ENT_STATE_DEAD;
				
				// Play sound
				_soundClipCollect.play();
			}
		}
		
		override public function render(camOffset:Point):void {
			_graphicsPos.x = (_pos.x - 8) - camOffset.x;
			_graphicsPos.y = (_pos.y - 8) - camOffset.y;
			Main.renderManager.drawObject(_sprite.bitmapData, _graphicsPos.x, _graphicsPos.y);
		}
		
	}

}