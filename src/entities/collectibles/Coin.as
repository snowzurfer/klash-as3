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
	 * The famous coin, available in every platformer out there.
	 * @author Alberto Taiuti
	 */
	public class Coin extends Collectible
	{
		
		public function Coin(xPos:int, yPos:int) {
			super(xPos, yPos, Constants.ENTITY_COIN);
			
			_boundingBox = new Rectangle(_pos.x - 4, _pos.y - 4, 8, 9);
			
			_soundClipCollect = (new Assets.coinCollectAudio) as Sound;
			
			_score = 20;
		}
		
		override public function initGraphics():void {
			_sprite = new Assets.goldcoinSprite();
		}
		
		override public function get boundingBox():Rectangle {
			_boundingBox.x = Math.floor(_desPos.x - 4);
			_boundingBox.y = Math.floor(_desPos.y - 4);
			
			return _boundingBox;
		}
	}

}