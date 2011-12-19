package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.IPileOwner;
	
	public class PlayArea extends PlayerPile
	{
		public function PlayArea(owner:IPileOwner){
			super(owner);
			tableVisibility = VISIBILITY_ALL;
			name = PileNames.PLAY_AREA;
		}
		
		/**
		 * When a card is added to the play area, it is considered 'played'.
		 * This triggers the cards play method, which mostly affects action cards.
		 */
		override public function add(card:Card):void{
			super.add(card);
			card.play();
		}
		
	}
}