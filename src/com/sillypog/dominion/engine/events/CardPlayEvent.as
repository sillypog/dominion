package com.sillypog.dominion.engine.events
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.vo.CardPlayParameters;
	
	import flash.events.Event;
	
	public class CardPlayEvent extends Event
	{
		public static var CARD_PLAYED:String = 'Card Played';
		
		private var _card:Card;
		private var _steps:Vector.<CardPlayParameters>;
		
		public function CardPlayEvent(card:Card, steps:Vector.<CardPlayParameters>)
		{
			super(CARD_PLAYED, false, false);
			
			_card = card;
			_steps = steps;
		}
		
		public function get card():Card{
			return _card;
		}
		
		public function get steps():Vector.<CardPlayParameters>{
			return _steps;
		}
	}
}