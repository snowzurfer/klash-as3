package leaffmk.UI 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.Rectangle;
	import leaffmk.custom_events.LmBtnEvent;
	import leaffmk.input.LmMouse;
	import leaffmk.UI.LmUI_element;
	
	/**
	 * Interactive button with text.
	 * @author Alberto Taiuti
	 */
	public class LmTextButton extends LmUI_element
	{
		// Text inside the button
		protected var _text:TextField;
		private var _textMatrix:Matrix = new Matrix(1, 0, 0, 1, 0, 0);
		protected var _textBMD:BitmapData;
		
		// Properties of the button
		private var _hovered:Boolean;
		private var _clicked:Boolean;
		private var _nameID:String; // name identifier
		
		private var _func:Function;
		
		// Texture for non-hovering
		private var _bgHovered:Bitmap;
		
		
		/**
		 * The mighty constructor
		 * @param	nameId	Name identifier for the button
		 * @param	x	X pos
		 * @param	y	Y pos	
		 * @param	width	Width of element
		 * @param	height	Height of element
		 * @param	textStr	Text to be displayed
		 * @param	textFormat	Specify formatting of text
		 * @param	background	Wether it has a background
		 * @param	bgColour	Main bg colour
		 * @param	bgColHovered	Colour used when hovered
		 * @param	func	Function to be assigned to the button
		 */
		public function LmTextButton(nameId:String, x:Number=0, y:Number=0, width:int=10, height:int=10, textStr:String = "Button", textFormat:TextFormat = null, bgNorm:Class = null, bgHover:Class =null, func:Function = null) {
			super(x, y, width, height, bgNorm);
			
			_bgHovered = new bgHover();
			
			_text = new TextField();
			// If no format was specified
			if (textFormat == null) {
				textFormat = new TextFormat("Arial", 20, 0x000000, true);
				textFormat.align = "center";
			}
			
			textFormat.align = "center";
			
			_text.width = width - 40; _text.height = height - 10;
			_text.defaultTextFormat = textFormat;
			_text.x = (x + (width * 0.5)) - (_text.width * 0.5); _text.y = (y + (height * 0.5)) - (_text.height * 0.5);
			_text.text = textStr;
			
			
			// Create a new transf. matrix and transform it
			_textBMD = new BitmapData(_text.width, _text.height);
			_textBMD.draw(_text); // Render text on BMD for fast rendering later
			
			_hovered = false; _clicked = false;
			_func = func;
			
			_nameID = nameId;
		}
		
		override public function update():void {
			// Check for hovering
			if (_shape.containsPoint(LmMouse.mousePos)) {
				// Set flag
				_hovered = true;
				// Dispatch event
				this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
				
				// Check for mouse click on the button
				if (LmMouse.mouseClicked) {
					// Dispatch event
					this.dispatchEvent(new LmBtnEvent(LmBtnEvent.BTN_CLICK, _nameID));
					// Set flag
					_clicked = true;
					_hovered = false;
					trace("Clicked ma btn!");
				}
				else {
					_clicked = false;
				}
			}
			else {
				// Set flags to false if previous conditions are false
				_hovered = false; 
				_clicked = false;
			}
		}
		
		override public function render():void {
			// If not visible
			if (!_visible)
				return; // Exit
			
			
			// If mouse hovering over it
			if (_hovered) {
				Main.renderManager.drawObject(_bgHovered.bitmapData, _shape.x, _shape.y);
			}
			else {
				Main.renderManager.drawObject(_imgBM.bitmapData, _shape.x, _shape.y);
			}
			
			// Render text
			Main.renderManager.drawObject(_textBMD, _text.x, _text.y);
		}
		
		public function get nameID():String {
			return _nameID;
		}
		
		public function set nameID(value:String):void {
			_nameID = value;
		}
		
		
	}
}