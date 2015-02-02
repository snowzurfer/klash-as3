package graphics 
{
	import flash.utils.Dictionary;
	/**
	 * Contains definitions and embeddeds for all the assets.
	 * This way the embedded files will not have loading problems being loaded
	 * everywhere in the code.
	 * @author Alberto Taiuti
	 */
	public class Assets 
	{
		// Background and map assets
		[Embed(source="../../assets/bg_mainmenu.png")]// MAIN MENU BG
		public static const bgMainMenu:Class;
		[Embed(source="../../assets/test_map.tmx", mimeType="application/octet-stream")] // TILED MAP
		public static const mapLevel_0:Class;
		[Embed(source="../../assets/tileset_0.png")] // TILED TILESET
		public static const tileset_0:Class;
		[Embed(source = "../../assets/bg_ingame.png")] // BG IN GAME
		public static const bgInGame:Class;
		[Embed(source = "../../assets/bg_credits.png")] // BG CREDITS
		public static const bgCredits:Class;
		[Embed(source = "../../assets/bg_controls.png")] // BG CONTROLS
		public static const bgControls:Class;
		[Embed(source = "../../assets/bg_gameover.png")] // BG GAMEOVER
		public static const bgGameOver:Class;
		
		
		
		// Buttons textures
		
		
		// UI
		[Embed(source = "../../assets/heart_UI.png")] // HEART FOR UI
		public static const heartUISprite:Class;
		
		
		// Entities assets
		[Embed(source="../../assets/player_mov_left.png")] // PLAYER MOVEMENT LEFT
		public static const playerMovLeft:Class; 
		[Embed(source = "../../assets/player_mov_right.png")] // PLAYER MOVEMENT RIGHT
		public static const playerMovRight:Class; 
		[Embed(source = "../../assets/player_shoot.png")] // PLAYER SHOOT RIGHT
		public static const playerShootRight:Class; 
		[Embed(source="../../assets/player_shoot_left.png")] // PLAYER SHOOT LEFT
		public static const playerShootLeft:Class; 
		[Embed(source="../../assets/skeleton_mov_right.png")] // SKELETON MOVE RIGHT
		public static const skeletonMovRight:Class; 
		[Embed(source="../../assets/skeleton_mov_left.png")] // SKELETON MOVE LEFT
		public static const skeletonMovLeft:Class; 
		[Embed(source = "../../assets/silverstatue_sprite.png")] // SILVER STATUE
		public static const silverStatueSprite:Class;
		[Embed(source = "../../assets/goldcoin_sprite.png")] // GOLD COIN
		public static const goldcoinSprite:Class;
		[Embed(source="../../assets/ghost_mov_right.png")] // GHOST MOVE RIGHT
		public static const ghostMovRight:Class;
		[Embed(source="../../assets/ghost_mov_left.png")] // GHOST MOVE LEFT
		public static const ghostMovLeft:Class;
		[Embed(source = "../../assets/chest_sprite.png")] // CHEST
		public static const chestSprite:Class;
		[Embed(source="../../assets/bat_mov_left.png")] // BAT MOVE LEFT
		public static const batMovLeft:Class;
		[Embed(source="../../assets/bat_mov_right.png")] // BAT MOVE RIGHT
		public static const batMovRight:Class;
		[Embed(source = "../../assets/smallheart_full_sprite.png")] // SMALL HEART
		public static const smallHeartSprite:Class;
		[Embed(source = "../../assets/diamond_sprite.png")] // DIAMOND
		public static const diamondSprite:Class;
		
		
		// Audio effects and songs
		[Embed(source="../../assets/audio/8bp113-01-sievert-ahoy_selection.mp3")] // INGAME
		public static const ingameAudio:Class;
		[Embed(source="../../assets/audio/8bp113-03-sievert-3_beers_deep_selection.mp3")] // MENU
		public static const menuAudio:Class;
		[Embed(source="../../assets/audio/Hit_Hurt6.mp3")] // HURT
		public static const hurtAudio:Class;
		[Embed(source="../../assets/audio/Jump9.mp3")] // JUMP
		public static const jumpAudio:Class;
		[Embed(source="../../assets/audio/Laser_Shoot26.mp3")] // SHOOT
		public static const shootAudio:Class;
		[Embed(source="../../assets/audio/Pickup_Coin30.mp3")] // STATUE COLLECT
		public static const goldenstatueCollectAudio:Class;
		[Embed(source="../../assets/audio/Pickup_Coin31.mp3")]// COIN COLLECT
		public static const coinCollectAudio:Class;
		[Embed(source="../../assets/audio/Pickup_Coin33.mp3")] // DIAMOND COLLECT
		public static const diamondCollectAudio:Class;
		[Embed(source="../../assets/audio/Pickup_Coin8.mp3")] // CHEST COLLECT
		public static const chestCollectAudio:Class;
	}

}