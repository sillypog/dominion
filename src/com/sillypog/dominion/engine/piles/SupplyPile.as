package com.sillypog.dominion.engine.piles
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.vo.BuyParameters;
	import com.sillypog.dominion.engine.vo.Cost;
	
	import flash.events.Event;

	public class SupplyPile extends Pile
	{
		private var _cardType:Card;
		private var _count:uint;
		
		public function SupplyPile(owner:IPileOwner, cardType:Card, startingNumber:uint){
			super(owner);
			
			_cardType = cardType;
			_count = startingNumber;
			
			tableVisibility = VISIBILITY_TOP;
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
				dispatchEvent(new Event(Event.CHANGE));
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
				dispatchEvent(new Event(Event.CHANGE));
			} else {
				throw new Error('Card added to wrong pile');
			}
		}
		
		override public function showVisibleCards(requester:IPileOwner):Vector.<Card>{
			var visibleCards:Vector.<Card> = super.showVisibleCards(requester);
			visibleCards.push(_cardType);
			return visibleCards;
		}
		
		/**
		 * This method will need to be refined to include other restictions, eg not having any copper in play.
		 */
		public function purchasable(parameters:BuyParameters):Boolean{
			var cost:Cost = _cardType.cost;
			return cost.met(parameters.treasure);
		}
		
	}
}