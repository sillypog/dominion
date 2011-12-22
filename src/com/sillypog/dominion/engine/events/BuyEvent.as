package com.sillypog.dominion.engine.events
{
	import com.sillypog.dominion.engine.vo.BuyParameters;
	
	import flash.events.Event;
	
	public class BuyEvent extends Event
	{
		public static const CHOOSE_BUY:String = 'Choose Buy';
		
		private var _parameters:BuyParameters;
		
		public function BuyEvent(type:String, parameters:BuyParameters)
		{
			super(type, false, false);
			
			_parameters = parameters;
		}
		
		public function get parameters():BuyParameters{
			return _parameters;
		}
	}
}