package com.sillypog.utils  {
	
	/**
	 * A slightly faster way of getting a random number than using Math.random().
	 * 
	 * <p>When creating an instance of this class, an optional seed value can be supplied.
	 * This can be useful when debugging as the same random sequence will always be used.</p> 
	 * 
	 * @example
	 * <listing version="3.0">
	 * var randomiser:XORandomiser = new XORandomiser();
	 * trace('Random number:', randomiser.random());
	 * </listing>
	 */
	public class XORandomiser {
		
		private const MAX_RATIO:Number = 1 / uint.MAX_VALUE;
		private var r:uint;

		/**
		 * @param seed For debugging, supply an integer value between 0 and uint.MAX_VALUE
		 */
		public function XORandomiser(seed:Number = -1) {
			if (seed < 0){
				r = Math.random() * uint.MAX_VALUE;
			} else {
				r = seed;
			}
		}
		
		/**
		 * Call this function to generate a random number.
		 * @return A random floating point number between 0 and 1.
		 */
		public function random():Number{
		
			r ^= (r << 21);	
			r ^= (r >>> 35);
			r ^= (r << 4);
			
			return (r * MAX_RATIO);
		}


	}
}
