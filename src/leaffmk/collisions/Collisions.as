package leaffmk.collisions 
{
	import flash.geom.Rectangle;
	
	/**
	 * Contains functions for collision handling
	 * @author Alberto Taiuti
	 */
	public class Collisions 
	{
		
		public function Collisions() 
		{
			
		}
		
		public static function check_collision( A:Rectangle, B:Rectangle):Boolean {
			//The sides of the rectangles
			var leftA:int; var leftB:int;
			var rightA:int; var rightB:int;
			var topA:int; var topB:int;
			var bottomA:int; var bottomB:int;

			//Calculate the sides of rect A
			leftA = A.x;
			rightA = A.x + A.width;
			topA = A.y;
			bottomA = A.y + A.height;

			//Calculate the sides of rect B
			leftB = B.x;
			rightB = B.x + B.width;
			topB = B.y;
			bottomB = B.y + B.height;

			//If any of the sides from A are outside of B
			if( bottomA <= topB )
			{
				return false;
			}

			if( topA >= bottomB )
			{
				return false;
			}

			if( rightA <= leftB )
			{
				return false;
			}

			if( leftA >= rightB )
			{
				return false;
			}

			//If none of the sides from A are outside B
			return true;
		}
		
	}

}