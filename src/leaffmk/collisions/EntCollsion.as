package leaffmk.collisions 
{
	import leaffmk.entities.BasicObject;
	
	/**
	 * Represents the collision between two entities
	 * @author Alberto Taiuti
	 */
	public class EntCollsion 
	{
		// The entities involved in the collision
		private var _entA:BasicObject;
		private var _entB:BasicObject;
		
		/**
		 * The mighty constructor
		 * @param	entA
		 * @param	entB
		 */
		public function EntCollsion(entA:BasicObject, entB:BasicObject) {
			_entA = entA;
			_entB = entB;
		}
		
		public function get entA():BasicObject 
		{
			return _entA;
		}
		
		public function get entB():BasicObject 
		{
			return _entB;
		}
		
	}

}