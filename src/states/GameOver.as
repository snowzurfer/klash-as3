package states 
{
	import graphics.Assets;
	import leaffmk.states.BaseState;
	import leaffmk.custom_events.LmStateEvent;
	import leaffmk.input.Keyboard;
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.display.BitmapData;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	
	/**
	 * The state showed when you suck.
	 * @author Alberto Taiuti
	 */
	public class GameOver extends BaseState
	{
		// Has a background
		private var _backgroundBM:Bitmap;
		
		// UI
		private var _tfScore:TextField;
		private var _tScoreBMD:BitmapData;
		
		public function GameOver(data:Array) {
			super();
			
			_stateID = Constants.STATE_GAMEOVER;
			
			// Add the background
			_backgroundBM = new Assets.bgGameOver();
			
			
			_tfScore = new TextField();
			_tfScore.textColor = 0xFFFFFF;
			_tfScore.antiAliasType = AntiAliasType.NORMAL;
			_tfScore.background = false;
			_tfScore.alpha = 1.0;
			_tfScore.x = 75;
			_tfScore.y = 92;
			_tfScore.width = 200;
			var _textFormat:TextFormat = new TextFormat("Alagard", 24, 0xFFFFFF, true);
			_tfScore.defaultTextFormat = _textFormat;
			_tfScore.text = "Your score: " + data[0];
			//_tfScore.setTextFormat(_textFormat);
			
			// Add start button
			//var playBtn:LmTextButton = new LmTextButton("playBtn", (Main.renderManager.STAGE_WIDTH / 2) - 95, 200, 210, 69, "Play", new TextFormat("Buxton Sketch", 36, 0xFFFFFF, true), Assets.btnMainMenuNohover, Assets.btnMainMenuHover);
			//playBtn.addEventListener(LmBtnEvent.BTN_CLICK, onMouseClick);
			
			//_buttons.push(playBtn);
			/*_soundClip = (new Assets.menuAudio) as Sound;
			_soundChannel = new SoundChannel();
			_soundTransf = new SoundTransform(0.6);
			_soundChannel = _soundClip.play(0, 99999);
			_soundChannel.soundTransform = _soundTransf;
			*/
			// Add options button
			
			// Add about button
			
			_running = true;
		}
		
		override public function handleInput():void {
			if (Keyboard.isJustPressed(Keyboard.T)) {
				dispatchEvent(new LmStateEvent(LmStateEvent.CHANGE_STATE, Constants.STATE_INGAME));
			}
			else if (Keyboard.isJustPressed(Keyboard.M)) {
				dispatchEvent(new LmStateEvent(LmStateEvent.CHANGE_STATE, Constants.STATE_MENU));
			}
		}
		
		override public function render():void {
			// Render background
			Main.renderManager.drawObject(_backgroundBM.bitmapData, 0, 0);
			
			// Render everything else
		
			// Render UI
			Main.renderManager.drawObject(_tScoreBMD, _tfScore.x, _tfScore.y)
			
			super.render();
		}
		
		override public function initGraphics():void {
			
			_tScoreBMD = new BitmapData(_tfScore.width, _tfScore.height, true, 0x00000000);
			_tScoreBMD.draw(_tfScore);
		}
	}

}