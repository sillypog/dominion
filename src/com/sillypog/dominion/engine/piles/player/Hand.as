package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.piles.IPileOwner;
	
	
	public class Hand extends PlayerPile
	{
		public function Hand(owner:IPileOwner)
		{
			super(owner);
			tableVisibility = VISIBILITY_NONE;
			playerVisibility = VISIBILITY_ALL;
			name = PileNames.HAND;
		}
	}
}