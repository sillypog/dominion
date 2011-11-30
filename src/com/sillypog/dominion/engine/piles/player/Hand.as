package com.sillypog.dominion.engine.piles.player
{
	
	
	public class Hand extends PlayerPile
	{
		public function Hand()
		{
			super();
			tableVisibility = VISIBILITY_NONE;
			playerVisibility = VISIBILITY_ALL;
			name = PileNames.HAND;
		}
	}
}