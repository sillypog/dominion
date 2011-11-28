package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.piles.MixedPile;

	public class Discard extends MixedPile
	{
		public function Discard(){
			super();
			tableVisibility = VISIBILITY_TOP;
		}
		
		public function shuffle():void{
			
		}
	}
}