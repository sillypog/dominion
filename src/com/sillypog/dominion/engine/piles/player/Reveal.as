package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.piles.IPileOwner;

	public class Reveal extends PlayerPile
	{
		public function Reveal(owner:IPileOwner)
		{
			super(owner);
			tableVisibility = VISIBILITY_ALL;
			name = PileNames.REVEAL;
		}
	}
}