package leaffmk.collisions 
{
	/**
	 * Represents the processed collision between two entities
	 * @author Alberto Taiuti
	 */
	public class ProcEntCollsion 
	{
		// The IDs of the two entities
		private var _entAID:int;
		private var _entBID:int;
		
		
		public function ProcEntCollsion(entAID:int, entBID:int) {
			_entAID = entAID;
			_entBID = entBID;
		}
		
		public function get entAID():int 
		{
			return _entAID;
		}
		
		public function get entBID():int 
		{
			return _entBID;
		}
	}

}