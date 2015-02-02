package leaffmk.maths 
{
	/**
	 * 2D vector
	 * @author Alberto Taiuti
	 */
	public class Vector2 
	{
		// The vector's components
		private var _xComp:Number;
		private var _yComp:Number;
		
		/**
		 * The mighty constructor
		 * @param	xComp	X Component 
		 * @param	yComp	Y Component
		 */
		public function Vector2(xComp:Number, yComp:Number) 
		{
			_xComp = xComp; _yComp = yComp;
		}
		
		/**
		 * The secopnd mighty constructor
		 * @param	mag		Magnitude 
		 * @param	ang		Angle to the x-axis (RADIANS)
		 */
		/*public function Vector2(mag:Number, ang:Number) 
		{
			_xComp = Math.cos(ang) * mag; _yComp = Math.sin(ang) * mag;
		}*/
		
		
		/**
		 * Add this vector to another one, and return the vector modified
		 * @param	v	The vector to be added
		 * @return	The vector after it has been modified
		 */
		public function AddTo( v:Vector2 ):Vector2
		{
			_xComp += v._xComp;
			_yComp += v._yComp;
			
			return this;
		}
		
		/**
		 * Subtract this vector to another one, and return the vector modified
		 * @param	v	The vector to be subtracted
		 * @return	The vector after it has been modified
		 */
		public function SubFrom( v:Vector2 ):Vector2
		{
			_xComp -= v._xComp;
			_yComp -= v._yComp;
			
			return this;
		}
		
		/**
		 * Subtract scalar from the vector
		 * @param	s	The scalar
		 * @return	Modified vector
		 */
		public function SubScalarFrom( s:Number ):Vector2
		{
			_xComp -= s;
			_yComp -= s;
			
			return this;
		}
		
		/**
		 * Add scalar to the vector
		 * @param	s	The scalar
		 * @return	Modified vector
		 */
		public function AddScalarTo( s:Number ):Vector2
		{
			_xComp += s;
			_yComp += s;
			
			return this;
		}
		
		/**
		 * Multiply this vector with v
		 * @param	v Vector to be multiplied
		 * @return	This vector after modifies
		 */
		public function mulTo( v:Vector2):Vector2
		{
			_xComp *= v._xComp;
			_yComp *= v._yComp;
			
			return this;
		}
		
		/**
		 * Divide this vector with v
		 * @param	v Vector to be divided
		 * @return	This vector after modifies
		 */
		public function divTo( v:Vector2):Vector2
		{
			_xComp /= v._xComp;
			_yComp /= v._yComp;
			
			return this;
		}
		
		/**
		 * Multiply this vector with s
		 * @param	s Scalar to be multiplied
		 * @return	This vector after modifies
		 */
		public function mulScalarTo( s:Number):Vector2
		{
			_xComp *= s;
			_yComp *= s;
			
			return this;
		}
		
		/**
		 * Divide this vector with s
		 * @param	s Scalar to be divided
		 * @return	This vector after modifies
		 */
		public function divScalarTo( s:Number):Vector2
		{
			_xComp /= s;
			_yComp /= s;
			
			return this;
		}
		
		/**
		 * Return the dot product between this vector and v
		 * @param	v	Vector to be projected
		 * @return	Dot product
		 */
		public function dot( v : Vector2 ):Number
		{
			return _xComp * v._xComp + _yComp * v._yComp;
		}
		
		/**
		 * Return the right normal
		 */
		public function get normR():Vector2
		{
			return new Vector2(-1 * this._yComp, this._xComp);
		}
		
		/**
		 * Return the left normal
		 */
		public function get normL():Vector2
		{
			return new Vector2(this._yComp, -1 * this._xComp);
		}
		
		/**
		 * Rotate around the origin this vector
		 * @param	ang		Angle in RADIANS
		 * @return		Vector after rotation
		 */
		public function rotate(ang:Number):Vector2
		{
			// Store the trigs of the angle, to save CPU (they won't be computed again)
			var cosAngle:Number = Math.cos(ang);
			var sinAngle:Number = Math.sin(ang);
			
			// Rotate the direction around the origin
			var rotatedX:Number = _xComp*cosAngle - _yComp*sinAngle;
			var rotatedY:Number = _xComp*sinAngle + _yComp*cosAngle;
			
			// Assign values back
			_xComp = rotatedX; _yComp = rotatedY;
			
			return this;
		}
		
		/**
		 * Return the unit vector of this vector
		 */
		public function get unitVector():Vector2 {
			return new Vector2(_xComp / magnitude, _yComp / magnitude);
		}
		
		
		
		
		
		
		
		// Getters and setters for the components
		public function get xComp():Number
		{
			return _xComp;
		}
		public function set xComp(val:Number):void
		{
			_xComp = val;
		}
		public function get yComp():Number
		{
			return _yComp;
		}
		public function set yComp(val:Number):void
		{
			_yComp = val;
		}
		/**
		 * Get magnitude of the vector
		 */
		public function get magnitude():Number 
		{
			return Math.sqrt((_xComp * _xComp) + (_yComp * _yComp));
		}
		/**
		 * Set magnitude of vector
		 */
		public function set magnitude(value:Number):void 
		{
			// Retrievee angle
			var curr_angle:Number = angle;
			
			// Set values
			_xComp = value * Math.cos(curr_angle);
			_xComp = value * Math.sin(curr_angle);
		}
		/**
		 * Get angle of vector
		 */
		public function get angle():Number 
		{
			return Math.atan2(_yComp, _xComp);
		}
		/**
		 * Set angle of vector
		 */
		public function set angle(value:Number):void 
		{
			// Retrieve magnitude
			var current_magnitude:Number = magnitude;
			
			//Set values
			_xComp = current_magnitude * Math.cos(value);
			_yComp = current_magnitude * Math.sin(value);
		}
	}

}