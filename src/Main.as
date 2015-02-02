package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import leaffmk.graphics.RenderManager;
	import states.StateManager;
	import flash.utils.getTimer;
	import leaffmk.input.Keyboard;
	import leaffmk.UI.LmTextButton;
	import graphics.Assets;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import leaffmk.input.LmMouse;
	import Constants;
	import leaffmk.graphics.LmCamera;

	
	
	/**
	 * leaf-framework is a framework (obviously) coded in AS3 for agile
	 * development of my flash games. Initially developed as the basis
	 * for a coursework of the 1st year CGT course at Abertay Dundee, it has expanded
	 * and has being used in many of my flash games. 
	 * Used also as a blueprint for the JS orange-framework.
	 * @author Alberto Taiuti
	 */	
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		
	
		public static var renderManager:RenderManager;
		public static var camera:LmCamera;
		private var stateManager:StateManager;
		
		private var frames:int=0;
		private var prevTimer:Number=0;
		private var curTimer:Number = 0;
		
		private var fpsText:TextField;
		
		// Fix time step
		private var _step:Number = 1 / Constants.FPS;
		
		// Current and previous time. Used for deltaTime calculation
		private var _currTime:Number;
		private var _prevTime:Number;
		
		// Delta time
		private var _dt:Number = 0;
		
		
		
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// Entry point for the game
			
			// Create the render manager
			renderManager = new RenderManager(stage.stageWidth, stage.stageHeight);
			addChild(renderManager.bitmap);			
			trace("Renderer base bitmap added to the Main!");
			
			// Create the states manager
			stateManager = new StateManager(Constants.STATE_MENU);
			
			// Subscribe to keyboard events
			stage.addEventListener(KeyboardEvent.KEY_DOWN, Keyboard.onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, Keyboard.onKeyUp);
			
			// Subscribe to mouse events
			stage.addEventListener(MouseEvent.MOUSE_MOVE, LmMouse.onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, LmMouse.onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, LmMouse.onMouseUp);
			
			fpsText = new TextField();
			fpsText.x = 20; fpsText.y = 20;
			
			// Initialize previous time variable
			_prevTime = getTimer();
			
			// Main game loop
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		private function onEnterFrame(e:Event):void {
			//playerBMP.x +=  0.2;
			
			stateManager.handleInput();
			
			// Calculate deltatime
			_currTime = getTimer();
			_dt = _dt + Math.min(1, ((_currTime - _prevTime) * 0.001)); // Convert to seconds
			while (_dt > _step) {
				_dt -= _step;
				stateManager.update(_step); // Update the current state using deltatime
			}
			
			stateManager.render();
			
			
			// Render everything
			renderManager.renderBuffer();
			
			
			// Render FPS on screen
			//renderManager.drawObject(fpsText, fpsText.x, fpsText.y);
			
			frames+=1;
			curTimer=getTimer();
			if (curTimer - prevTimer >= 1000) {
				var fps:Number = Math.round(frames * 1000 / (curTimer - prevTimer));
				fpsText.text =  fps.toString();
				prevTimer=curTimer;
				frames=0;
			}
			
			// Reset keyboard containers
			Keyboard.reset();
			
			// Reset mouse flags
			LmMouse.reset();
			
			// Reset timer
			_prevTime = _currTime;	
		}
	}
}