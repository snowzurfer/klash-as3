package entities 
{
	import flash.geom.Rectangle;
	import leaffmk.entities.BasicObject;
	import Constants;
	
	/**
	 * The collider is an invisble object interacting only with enemies:
	 * when they collide with it, they invert their direction
	 * @author Alberto Taiuti
	 */
	public class Collider extends BasicObject
	{
		public function Collider(xPos:int, yPos:int) {
			super(xPos, yPos, Constants.ENTITY_COLLIDER);
			
			_boundingBox = new Rectangle(xPos - 5, yPos - 5, 10, 10);
		}
		
	}

}