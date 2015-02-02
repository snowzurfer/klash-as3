package  
{
	/**
	 * Constants stuff that has to be reached by all the classes
	 * @author Alberto Taiuti
	 */
	public class Constants_mod
	{
		// Define map size
		public static const MAP_SIZE_TW:int = 64;
		public static const MAP_SIZE_TH:int = 48;
		
		
		// Define IDs for background layers
		public static const BGID_SKY:int = 0;
		public static const BGID_RIVERBANK:int = 1;
		public static const BGID_RIVERSIDECLOSE:int = 2;
		public static const BGID_RIVERSIDE:int = 3;
		
		// States ID
		public static const STATE_INTRO:int = 0;
		public static const STATE_PRELOADER:int = 1;
		public static const STATE_MENU:int = 2;
		public static const STATE_INGAME:int = 3;
		public static const STATE_SHOP:int = 4;
		public static const STATE_PAUSE:int = 5;
		public static const STATE_CREDITS:int = 6;
		public static const STATE_GAMEOVER:int = 7;
		
		// Events conts
		public static const EV_CHANGESTATE:String = "changeState"; 
		public static const EV_CHANGESTATE_TOPLAY:String = "changeState_toPlay";
		public static const EV_CHANGESTATE_TOMENU:String = "changeState_toMenu";
		
	}
}