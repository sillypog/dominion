package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.piles.IPileOwner;

	public class Deck extends PlayerPile
	{
		public function Deck(owner:IPileOwner)
		{
			super(owner);
			tableVisibility = VISIBILITY_NONE;
			name = PileNames.DECK;
		}
	}
}