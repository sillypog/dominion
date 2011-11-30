package com.sillypog.dominion.engine.commands
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.player.Deck;
	import com.sillypog.dominion.engine.piles.player.Discard;
	import com.sillypog.dominion.engine.piles.player.Hand;
	import com.sillypog.dominion.engine.piles.player.PileNames;

	public class C_PlayerDrawCards implements ICommand
	{
		private var _player:Player;
		private var _numCards:int;
		
		public function C_PlayerDrawCards(player:Player, numCards:int = 1){
			_player = player;
			_numCards = numCards;
		}
		
		public function execute():void{
			var deck:Deck = Deck(_player.getPileByName(PileNames.DECK));
			var hand:Hand = Hand(_player.getPileByName(PileNames.HAND));
			var discard:Discard = Discard(_player.getPileByName(PileNames.DISCARD));
			
			var drawnCard:Card;
			
			for (var i:int = 0; i < _numCards; i++){
				drawnCard = deck.draw();
				if (!drawnCard){
					if (discard.count > 0){
						// Shuffle discard, move cards to deck
						discard.shuffle();
						deck.addCards(discard.removeAllCards());
						drawnCard = deck.draw();	// Try again 
					} else {
						break;	// No card left to draw
					}
				}
				hand.add(drawnCard);
			}
		}
	}
}