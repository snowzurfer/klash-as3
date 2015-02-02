package leaffmk.states
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import leaffmk.UI.LmTextButton;
	import flash.text.TextFormat;
	import flash.text.TextField;
	
	/**
	 * Represents one state
	 * @author Alberto Taiuti
	 */
	public class BaseState extends EventDispatcher
	{
		
		// Array of buttons in the state
		protected var _buttons:Array;
		// Array of textfields in the state
		protected var _texts:Array;
		
		// Wether it is paused or not
		protected var _running:Boolean;
		
		// ID of the state
		protected var _stateID:int;
		
		
		/**
		 * The mighty constructor
		 */
		public function BaseState() {
			_running = false;
			
			_buttons = new Array();
			_texts = new Array();
		}
		
		
		public function handleInput():void {
			
		}
		
		public function update(dt:Number):void {
			// Update UI
			for (var j:int = 0; j < _buttons.length; j++)
				_buttons[j].update();
		}
		
		public function render():void {
			// Render buttons and texts
			/*for (var i:int = 0; i < _texts.length; i++) 
				Main.renderManager.drawObject(_texts[i], _texts[i].x, _texts[i].y);*/
			for (var j:int = 0; j < _buttons.length; j++)
				_buttons[j].render();
		}
		
		// Getters and setters
		public function set running(value:Boolean):void {
			_running = value;
		}
		public function get running():Boolean {
			return _running;
		}
		
		public function initGraphics():void {
			
		}
		
		
		// Swap two elements of an array
		public function swapPos(p:Array, posA:int, posB:int):void {
			var temp:int = p[posA];
			p[posA] = p[posB];
			p[posB] = temp;
		}
		
		/*protected function addTextBtn(x:Number=0, y:Number=0, width:int=10, height:int=10, textStr:String = "Button", textFormat:TextFormat = null, bgNorm:Class = null, bgHover:Class =null, func:Function = null):void {
			// If no format was specified
			if (textFormat == null) {
				textFormat = new TextFormat("Arial", 20, 0x000000, true);
				textFormat.align = "center";
			}
				
			_buttons.push(new LmTextButton(x, y, width, height, textStr, textFormat, bgNorm, bgHover, func));  
		}
		
		public function AddText(x:Number, y:Number, width:int, height:int, textStr:String, format:TextFormat=null, colour:uint=0xFFFFFF, font:String="Arial", fontSize:int=20):void {
			var text:TextField = new TextField();
			
			// If no format has been passed
			if (format == null)
				format = new TextFormat(font, fontSize, colour);
 
			text.width = width;
			text.height = height;
			text.defaultTextFormat = format;
			text.x = x;
			text.y = y;
			text.text = textStr;
			
			// Push it back
			_texts.push(text);
		}*/
	}

}