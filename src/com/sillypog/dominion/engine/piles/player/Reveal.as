package com.sillypog.dominion.engine.piles.player
{
	public class Reveal extends PlayerPile
	{
		public function Reveal()
		{
			super();
			tableVisibility = VISIBILITY_ALL;
			name = PileNames.REVEAL;
		}
	}
}