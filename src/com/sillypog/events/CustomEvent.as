package com.sillypog.events
{
	import flash.events.Event;
	
	public class CustomEvent extends Event
	{
		private var _info:Object;
		
		public function CustomEvent(type:String, info:Object){
			super(type);
			
			_info = info;
		}
		
		public function get info():Object{
			return _info;
		}
	}
}