package entities.collectibles 
{
	import flash.media.Sound;
	import leaffmk.entities.BasicObject;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import Constants;
	import graphics.Assets;
	import flash.geom.Rectangle;
	import entities.collectibles.Collectible;
	
	/**
	 * Collectible chest, full of gold!
	 * @author Alberto Taiuti
	 */
	public class Chest extends Collectible
	{
		
		
		public function Chest(xPos:int, yPos:int) {
			super(xPos, yPos, Constants.ENTITY_CHEST);
			
			_boundingBox = new Rectangle(_pos.x - 8, _pos.y - 7, 16, 14);
	
			_soundClipCollect = (new Assets.chestCollectAudio) as Sound;
			
			_score = 40;
		}
		
		override public function initGraphics():void {
			_sprite = new Assets.chestSprite();
		}
		
		override public function get boundingBox():Rectangle {
			_boundingBox.x = Math.floor(_desPos.x - 8);
			_boundingBox.y = Math.floor(_desPos.y - 7);
			
			return _boundingBox;
		}
		
	}

}