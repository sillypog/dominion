package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.piles.IPileOwner;
	

	public class PlayArea extends PlayerPile
	{
		public function PlayArea(owner:IPileOwner){
			super(owner);
			tableVisibility = VISIBILITY_ALL;
			name = PileNames.PLAY_AREA;
		}
		
	}
}