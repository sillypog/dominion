package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.utils.XORandomiser;
	

	public class Discard extends PlayerPile
	{
		/**
		 * Using a seedable random number generator in case it helps for debugging.
		 * It may also help to be able to replay games using the same seed.
		 */
		private var randomiser:XORandomiser;
		
		public function Discard(){
			super();
			tableVisibility = VISIBILITY_TOP;
			name = PileNames.DISCARD;
			
			randomiser = new XORandomiser();
		}
		
		public function shuffle():void{
			var shuffledCards:Vector.<Card> = new Vector.<Card>();
			
			var index:int;
			for (var i:int = _cards.length-1; i > -1; --i){
				index = int(randomiser.random() * i);	// Round number down
				var card:Card = _cards.splice(index,1)[0];	// splice from a vector returns a vector, so just take the first element
				shuffledCards.push(card);
			}
			
			_cards = shuffledCards;
		}
	}
}