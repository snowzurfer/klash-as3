package leaffmk.graphics 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import leaffmk.entities.BasicObject;
	import Constants;
	
	/**
	 * Camera class
	 * @author Alberto Taiuti
	 */
	public class LmCamera 
	{
		private var _box:Rectangle;
		
		// Target to follow
		private var _target:BasicObject;
		
		/**
		 * The mighty contructor
		 * @param	xTopLeft
		 * @param	yTopLeft
		 * @param	width
		 * @param	height
		 */
		public function LmCamera(xTopLeft:int, yTopLeft:int, width:int, height:int, target:BasicObject) {
			_box = new Rectangle(xTopLeft, yTopLeft, width, height);
			
			_target = target;
		}
		
		public function update():void {
			// Centre camera on target entity
			_box.x = int(_target.pos.x - (_box.width / 2));
			_box.y = int(_target.pos.y  - (_box.height / 2));
			
			
			// Prevent camera from going out of world boundaries
			if(_box.x <= 0) {
				_box.x = 0;
			}
			else if (_box.right >= Constants.MAP_WIDTH) {
				_box.x = ( Constants.MAP_WIDTH) - _box.width;
			}
			if(_box.y <= 0) {
				_box.y = 0;
			}
			else if(_box.bottom >= Constants.MAP_HEIGHT) {
				_box.y = (Constants.MAP_HEIGHT) - _box.height;
			}
			
			//trace(_box.x + " " + _box.y);
		}
		
		public function get box():Rectangle 
		{
			return _box;
		}
		
		public function set box(value:Rectangle):void 
		{
			_box = value;
		}
		
	}

}