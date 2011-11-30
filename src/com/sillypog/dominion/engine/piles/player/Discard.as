package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.cards.Card;
	

	public class Discard extends PlayerPile
	{
		public function Discard(){
			super();
			tableVisibility = VISIBILITY_TOP;
			name = PileNames.DISCARD;
		}
		
		public function shuffle():void{
			var shuffledCards:Vector.<String> = new Vector.<String>();
			
			var index:int;
			for (var i:int = _cards.length-1; i > -1; --i){
				index = Math.floor(Math.random() * i);
				shuffledCards.push(_cards.splice(index,1));
			}
			
			_cards = shuffledCards;
		}
	}
}