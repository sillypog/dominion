package com.sillypog.events
{
	import flash.events.EventDispatcher;
	
	public class GlobalDispatcher extends EventDispatcher
	{
		private static var _instance:GlobalDispatcher;
		
		public function GlobalDispatcher(singleton:SingletonEnforcer){}
		
		public static function get instance():GlobalDispatcher{
			if (!_instance){
				_instance = new GlobalDispatcher(new SingletonEnforcer());
			} 
			return _instance;
		}
		
		/**
		 * This function is overriden to ensure that listeners are always set as weak references.
		 * Without this safeguard, there is a possibility that a content file will add a listener to the
		 * instance using regular syntax. When that content file is unloaded, it will not be released from
		 * memory unless that listener is explicitly removed before unloading is complete.
		 *
		 * @param useWeakReference This parameter has been left available in case people attempt to set it. However, the value will always be ignored and set to true.
		 */
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void{
			super.addEventListener(type, listener, useCapture, priority, true);	// useWeakReference always set to true
		}
	}
}

/////////////////
// END PACKAGE
/////////////////


/**
 * @private
 * Singleton enforcer - Internal use only
 */
class SingletonEnforcer{}