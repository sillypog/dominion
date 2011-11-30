package com.sillypog.dominion.engine.piles
{
	import com.sillypog.dominion.engine.CardLoader;
	import com.sillypog.dominion.engine.cards.Card;

	public class MixedPile extends Pile
	{
		/**
		 * Cards are stored by name. This avoids accumulating hundreds of Card objects as the game progresses.
		 */
		protected var _cards:Vector.<String>;
		
		public function MixedPile(){
			super();
			_cards = new Vector.<String>();
		}
		
		/**
		 * The number of cards in the pile.
		 */
		override public function get count():int{
			return _cards.length;
		}
		
		override public function add(card:Card):void{
			_cards.push(card.name);
		}
		
		/**
		 * Draws cards from the top of the pile.
		 * 
		 * @return Will be null if the pile was empty
		 */
		override public function draw():Card{
			if (_cards.length == 0){
				return null;
			} 
			var cardName:String = _cards.pop();
			
			// Have to create a new instance of the card
			var cardLoader:CardLoader = CardLoader.instance;
			var card:Card = cardLoader.createCard(cardName);
			return card;
			
		}
		
		
	}
}