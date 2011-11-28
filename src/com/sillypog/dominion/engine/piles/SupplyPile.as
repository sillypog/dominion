package com.sillypog.dominion.engine.piles
{
	import com.sillypog.dominion.engine.cards.Card;

	public class SupplyPile extends Pile
	{
		private var _cardType:Card;
		private var _count:uint;
		
		public function SupplyPile(cardType:Card, startingNumber:uint){
			super();
			
			_cardType = cardType;
			_count = startingNumber;
		}
		
		public function get cardType():Card{
			return _cardType;
		}
		
		/**
		 * This is the way that cards get from the supply into other decks.
		 * It should work as a factory function, returning a new instance of the correct card type.
		 */
		public function draw():Card{
			if (_count){
				_count--;
				return _cardType;	// Or should it create a cloned object of the same type?
			} else {
				throw new Error('Attempt to draw from empty pile');
			}
		}
	}
}