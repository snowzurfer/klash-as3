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
	 * Represents a collectible golden shiny statue
	 * @author Alberto Taiuti
	 */
	public class GoldenStatue extends Collectible
	{
		
		public function GoldenStatue(xPos:int, yPos:int) {
			super(xPos, yPos, Constants.ENTITY_GOLDENSKULL);
			
			_boundingBox = new Rectangle(_pos.x - 5, _pos.y - 8, 9, 16);
			
			_soundClipCollect = (new Assets.goldenstatueCollectAudio) as Sound;
			
			_score = 100;
		}
		
		override public function initGraphics():void {
			_sprite = new Assets.silverStatueSprite();
		}
		
		override public function get boundingBox():Rectangle {
			_boundingBox.x = Math.floor(_desPos.x - 5);
			_boundingBox.y = Math.floor(_desPos.y - 8);
			
			return _boundingBox;
		}
		
		
	}

}