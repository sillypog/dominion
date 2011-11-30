package com.sillypog.dominion.engine.piles.player
{
	public class Deck extends PlayerPile
	{
		public function Deck()
		{
			super();
			tableVisibility = VISIBILITY_NONE;
			name = PileNames.DECK;
		}
	}
}