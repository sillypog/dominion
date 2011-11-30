package com.sillypog.dominion.engine.piles.player
{
	

	public class Discard extends PlayerPile
	{
		public function Discard(){
			super();
			tableVisibility = VISIBILITY_TOP;
			name = PileNames.DISCARD;
		}
		
		public function shuffle():void{
			
		}
	}
}