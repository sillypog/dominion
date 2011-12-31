package com.sillypog.dominion.components
{
	import com.sillypog.dominion.engine.Table;
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.Pile;
	
	import flash.events.Event;
	import flash.text.TextField;

	public class CardButton extends ApplicationButton
	{
		private var _countLabel:TextField;
		private var pile:Pile;
		
		public function CardButton(pile:Pile)
		{
			this.pile = pile;
			var card:Card = pile.showVisibleCards(Table.instance.supply)[0];
			
			super(card.name);
			
			_countLabel = new TextField();
			_countLabel.text = String(pile.count);
			_countLabel.textColor = 0xFF0000;
			_countLabel.height = 20;

			addChild(_countLabel);
			
			pile.addEventListener(Event.CHANGE, updateCount);
		}
		
		public function get count():int{
			return int(_countLabel.text);
		}
		public function set count(value:int):void{
			_countLabel.text = String(value);
		}
		
		private function updateCount(e:Event):void{
			count = pile.count;
		}
	}
}