package com.sillypog.dominion.engine.events
{
	import com.sillypog.dominion.engine.vo.ChoiceParameters;
	
	import flash.events.Event;
	
	public class ChoiceEvent extends Event
	{
		public static const CHOOSE_FROM_PILE:String = 'Choose from Pile';
		
		private var _params:ChoiceParameters;
		
		public function ChoiceEvent(type:String, params:ChoiceParameters)
		{
			super(type, false, false);
			
			_params = params;
		}
		
		public function get params():ChoiceParameters{
			return _params;
		}
	}
}