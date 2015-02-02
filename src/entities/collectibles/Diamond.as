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
	 * A shiny collectible diamond
	 * @author Alberto Taiuti
	 */
	public class Diamond extends Collectible
	{
		
		public function Diamond(xPos:int, yPos:int) {
			super(xPos, yPos, Constants.ENTITY_DIAMOND);
			
			_boundingBox = new Rectangle(_pos.x - 8, _pos.y - 7, 15, 13);
			
			_score = 50;
			
			_soundClipCollect = (new Assets.diamondCollectAudio) as Sound;
		}
		
		override public function initGraphics():void {
			_sprite = new Assets.diamondSprite();
		}
		
		override public function get boundingBox():Rectangle {
			_boundingBox.x = Math.floor(_desPos.x - 8);
			_boundingBox.y = Math.floor(_desPos.y - 7);
			
			return _boundingBox;
		}
		
	}

}