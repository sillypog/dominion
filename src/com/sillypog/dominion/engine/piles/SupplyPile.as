package com.sillypog.dominion.engine.piles
{
	import com.sillypog.dominion.engine.cards.Card;

	public class SupplyPile extends Pile
	{
		private var _cardType:Card;
		private var _count:uint;
		
		public function SupplyPile(owner:IPileOwner, cardType:Card, startingNumber:uint){
			super(owner);
			
			_cardType = cardType;
			_count = startingNumber;
		}
		
		public function get cardType():Card{
			return _cardType;
		}
		
		/**
		 * The number of cards in the pile.
		 */
		override public function get count():int{
			return _count;
		}
		
		/**
		 * This is the way that cards get from the supply into other decks.
		 * It should work as a factory function, returning a new instance of the correct card type.
		 */
		override public function draw():Card{
			if (_count){
				_count--;
				return _cardType;	// Or should it create a cloned object of the same type?
			} else {
				throw new Error('Attempt to draw from empty pile');
			}
		}
		
		/**
		 * Adds a card to the pile
		 */
		override public function add(card:Card):void{
			if (card.name == _cardType.name){
				_count++;
			} else {
				throw new Error('Card added to wrong pile');
			}
		}
		
	}
}