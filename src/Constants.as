package  
{
	
	/**
	 * Constants stuff that has to be reached by all the classes
	 * @author Alberto Taiuti
	 */
	public class Constants 
	{
		// Define base graphics parameters
		public static const FPS:int = 60; // Number of FPS
		public static const SCREEN_WIDTH:int = 320; // Horizontal size of screen
		public static const SCREEN_HEIGHT:int = 240; // Vertical size of screen
		
		public static const BACKGROUND_SKY_COL:int = 0x31A2F2;
		
		
		
		// Physics engine cosnts
		public static const TILE_WIDTH:int = 16; // Tile size in px
		public static const TILE_HEIGHT:int = 16;
		public static const MAP_UNIT:int = 16;
		public static const GRAVITY:Number = 600 * 0.9; // Exaggerated gravity
		public static const MAX_DX:Number = 100* 0.9; // Max horizontal speed (in tiles per second)
		public static const MAX_DY_UP:Number = 224* 0.9; // Max vertical speed when moving upwards(in tiles per second)
		public static const MAX_DY_DOWN:Number = 450* 0.9; // Max vertical speed when falling (in tiles per second)
		public static const ACCEL:Number = 800* 0.9; // Horizontal acceleration 
		public static const FRICTION:Number = 700* 0.9; // Horizontal friction
		public static const JUMP_ACC:Number = 750 * 0.9; // Max horizontal speed (in tiles per second)
		public static const JUMP_CUTOFF:Number = 100 * 0.9;
		public static const HURT_IMPULSE_X:Number = 300 * 0.9;
		public static const HURT_IMPULSE_Y:Number = 100 * 0.9;
		public static const ENEMY_VEL:Number = 50 * 0.9;
		public static const BULLET_VEL:Number = 120 * 0.9;
		
		
		
		// Define map size
		public static const MAP_WIDTH_T:int = 62;
		public static const MAP_HEIGHT_T:int = 32;
		public static const MAP_WIDTH:int = MAP_WIDTH_T * TILE_WIDTH;
		public static const MAP_HEIGHT:int = MAP_HEIGHT_T * TILE_HEIGHT;
		
		
		// Define IDs for background layers
		/*public static const BGID_SKY:int = 0;
		public static const BGID_RIVERBANK:int = 1;
		public static const BGID_RIVERSIDECLOSE:int = 2;
		public static const BGID_RIVERSIDE:int = 3;*/
		
		// Define collidable Tile types
		public static const TILE_NULL:int = 0;
		public static const TILE_DIRT:int = 21;
		public static const TILE_TOPDIRT:int = 31;
		public static const TILE_SPIKES_A:int = 91;
		public static const TILE_SPIKES_B:int = 85;
		public static const TILE_SPIKES_C:int = 93;
		public static const TILE_SPIKES_D:int = 95;
		
		
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
		
		
		// Entity types
		public static const ENTITY_PLAYER:int = 0;
		public static const ENTITY_GHOST:int = 1;
		public static const ENTITY_SKELETON:int = 2;
		public static const ENTITY_BAT:int = 3;
		public static const ENTITY_DIAMOND:int = 4;
		public static const ENTITY_CHEST:int = 5;
		public static const ENTITY_GOLDENSKULL:int = 6;
		public static const ENTITY_COIN:int = 7;
		public static const ENTITY_LIFE:int = 8;
		public static const ENTITY_COLLIDER:int = 9;
		public static const ENTITY_BULLET:int = 10;
		
		
		// Entity states
		public static const ENT_STATE_MOVING:int = 0;
		public static const ENT_STATE_HURT:int = 1;
		public static const ENT_STATE_DEAD:int = 2;
		public static const ENT_STATE_IDLE:int = 3;
		public static const ENT_STATE_SHOOTING:int = 4;
		public static const ENT_STATE_JUMPING:int = 5;
		
		
		// Entity general constants
		public static const ENTITY_SIZE_PX:int = 16;
		
	}

}