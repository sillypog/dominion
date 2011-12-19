package com.sillypog.dominion.engine.commands
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.MixedPile;
	import com.sillypog.dominion.engine.piles.Pile;
	

	public class C_MoveCard implements ICommand
	{
		private var _card:Card;
		private var _source:MixedPile;
		private var _destination:MixedPile;
		
		public function C_MoveCard(card:Card, source:Pile, destination:Pile)
		{
			_card = card;
			_source = MixedPile(source);
			_destination = MixedPile(destination);
		}
		
		public function execute():void
		{
			_source.removeCard(_card);
			_destination.add(_card);
		}
	}
}