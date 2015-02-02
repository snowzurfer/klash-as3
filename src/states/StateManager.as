package states
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import leaffmk.states.BaseState;
	import flash.utils.getTimer;
	import leaffmk.input.Keyboard;
	import leaffmk.custom_events.LmStateEvent;
	import states.*;
	import Constants;
	
	/**
	 * Manager for the game states
	 * @author Alberto Taiuti
	 */
	public class StateManager extends EventDispatcher
	{
		
		
		// Hold current state
		private var _currState:BaseState;
		
		/**
		 * The mighty constructor
		 * @param	firstState	First state to be launched
		 */
		public function StateManager(firstState:int) {
			
			// Initialize first state
			switch(firstState) {
				case Constants.STATE_INGAME:
					_currState = new Play();
					break;
				case Constants.STATE_MENU:
					_currState = new MainMenu();
					break;
				/*case Constants.STATE_INTRO:
					_currState = new Intro();
					break;
				case Constants.STATE_PRELOADER:
					_currState = new Preloader();
					break;*/
			}
			
			// Subscribe for events from states
			_currState.addEventListener(LmStateEvent.CHANGE_STATE, onChangeState);
		}
		
		// Handle input
		public function handleInput():void {
			_currState.handleInput();
		}
		
		/**
		 * Initialize graphics for each entity of the current state
		 */
		public function initGraphics():void {
			_currState.initGraphics();
		}
		
		// Logic
		public function update(dt:Number):void {
			_currState.update(dt);
		}
		
		// Render
		public function render():void {
			// Refresh screen
			Main.renderManager.clearScreen("0xFFFFFF");
			
			// Render current state
			_currState.render();
		}
		
		// Calls the change state function according to the event
		public function onChangeState(e:LmStateEvent):void {
			// Switch state depending on the event
			switch(e.nextState) {
				case Constants.STATE_INGAME: {
					changeState(new Play());
					break;
				}
				case Constants.STATE_MENU: {
					changeState(new MainMenu());
					break;
				}
				case Constants.STATE_GAMEOVER: {
					changeState(new GameOver(e.customData));
					break;
				}
			}
		}
		
		private function changeState(newState:BaseState):void {
			// Clear the screen
			Main.renderManager.clearScreen("0x000000");
		
			// Create new instance of desired state
			_currState = newState;
			// Add event listener for state changes
			_currState.addEventListener(LmStateEvent.CHANGE_STATE, onChangeState);
			// Init its graphics
			_currState.initGraphics();
		}
	}
}