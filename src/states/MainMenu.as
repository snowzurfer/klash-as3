package states
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.TextFormat;
	import leaffmk.custom_events.LmStateEvent;
	import flash.text.TextField;
	import leaffmk.states.BaseState;
	import flash.display.Bitmap;
	import flash.display.Stage;
	import graphics.Assets;
	import leaffmk.input.Keyboard;
	import leaffmk.UI.LmTextButton;
	import Constants;
	import leaffmk.custom_events.LmBtnEvent;
	import flash.media.SoundTransform;
	
	/**
	 * Sample main menu for a game
	 * @author Alberto Taiuti
	 */
	public class MainMenu extends BaseState
	{	
		// Has a background
		private var _backgroundBM:Bitmap;
		
		// Has some text
		//private var _textField:TextField;
		
		// Background sound
		private var _soundClip:Sound;
		private var _soundChannel:SoundChannel;
		private var _soundTransf:SoundTransform;
		
		private var _showInstructions:Boolean = false;
		private var _showCredits:Boolean = false;
		
		/**
		 * The mighty constructor
		 */
		public function MainMenu() {
			super();
			
			_stateID = Constants.STATE_MENU;
			
			// Add the background
			_backgroundBM = new Assets.bgMainMenu();
			
			// Add start button
			//var playBtn:LmTextButton = new LmTextButton("playBtn", (Main.renderManager.STAGE_WIDTH / 2) - 95, 200, 210, 69, "Play", new TextFormat("Buxton Sketch", 36, 0xFFFFFF, true), Assets.btnMainMenuNohover, Assets.btnMainMenuHover);
			//playBtn.addEventListener(LmBtnEvent.BTN_CLICK, onMouseClick);
			
			//_buttons.push(playBtn);
			_soundClip = (new Assets.menuAudio) as Sound;
			_soundChannel = new SoundChannel();
			_soundTransf = new SoundTransform(0.6);
			_soundChannel = _soundClip.play(0, 99999);
			_soundChannel.soundTransform = _soundTransf;
			
			// Add options button
			
			// Add about button
			
			_running = true;
		}
		
		
		override public function handleInput():void {
			// If key S is being pressed
			if (Keyboard.isJustPressed(Keyboard.S)) {
				
				// If instructions have already been shown
				if (_showInstructions) {
					// Move to ingame state
					this.dispatchEvent(new LmStateEvent(LmStateEvent.CHANGE_STATE, Constants.STATE_INGAME));
					
					// Reset the running flag
					_running = false;
					
					// Stop playing music
					_soundChannel.stop();
				}
				
				// Set the flag to true so that next time the game will proceed
				_showInstructions = true;
				
				_backgroundBM = new Assets.bgControls;
			}
			
			if (Keyboard.isJustPressed(Keyboard.C)) {
				
				// If the credits have already been shown
				if (_showCredits && !_showInstructions) {
					// Set back to menu background
					_backgroundBM = new Assets.bgMainMenu();
					_showCredits = false;
				}
				
				// If the game has not already proceeded
				else if (!_showInstructions) {
					
					// Set the flag
					_showCredits = true;
					
					_backgroundBM = new Assets.bgCredits;
				}
				
				
			}
		}
		
		override public function update(dt:Number):void {
			// Update only if not stopped
			if (_running)
			{
				super.update(dt);
			}
		}
		
		override public function render():void {
			// Render background
			Main.renderManager.drawObject(_backgroundBM.bitmapData, 0, 0);
			
			// Render everything else
			
			// Render UI
			super.render();
		}
		
		private function onMouseClick(e:LmBtnEvent):void {
			// TODO fix name problem
			
			if (e.dispatcherName == "playBtn") {
				this.dispatchEvent(new LmStateEvent(LmStateEvent.CHANGE_STATE, Constants.STATE_INGAME));
				
				_running = false;
				
				
			}
		}
	}
}