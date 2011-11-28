package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.piles.MixedPile;
	
	public class Hand extends MixedPile
	{
		public function Hand()
		{
			super();
			tableVisibility = VISIBILITY_NONE;
			playerVisibility = VISIBILITY_ALL;
		}
	}
}