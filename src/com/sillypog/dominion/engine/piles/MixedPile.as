package com.sillypog.dominion.engine.piles
{
	import com.sillypog.dominion.engine.cards.Card;
	
	import flash.events.Event;
	
	public class MixedPile extends Pile
	{		
		/**
		 * Cards are stored as references to the Card object in supply piles.
		 */
		protected var _cards:Vector.<Card>;
		
		public function MixedPile(owner:IPileOwner){
			super(owner);
			_cards = new Vector.<Card>();
		}
		
		/**
		 * The number of cards in the pile.
		 */
		override public function get count():int{
			return _cards.length;
		}
		
		override public function add(card:Card):void{
			_cards.push(card);
			dispatchEvent(new Event(Event.CHANGE));
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
			var card:Card = _cards.pop();
			dispatchEvent(new Event(Event.CHANGE));
			return card;
		}
		
		override public function showVisibleCards(requester:IPileOwner):Vector.<Card>{
			var visibleCards:Vector.<Card> = super.showVisibleCards(requester);
			var len:int = 0;
			switch (tableVisibility){
				case this.VISIBILITY_TOP: len = 1;
					break;
				case this.VISIBILITY_ALL: len = count;
					break;
			}
			for (var i:int = count-len; i < count; i++){
				visibleCards.push(_cards[i]);
			}
			
			return visibleCards;
		}
		
		public function getCardsByType(type:String):Vector.<Card>{
			var cards:Vector.<Card> = new Vector.<Card>();
			var c:int = count;
			var card:Card;
			for (var i:int = 0; i < c; i++){
				card = _cards[i];
				if (card.isType(type)){
					cards.push(card);
				}
			}
			return cards;
		}
		
		public function removeCard(card:Card):Card{
			var index:int = _cards.indexOf(card);
			var removed:Vector.<Card> = _cards.splice(index,1);
			dispatchEvent(new Event(Event.CHANGE));
			return removed[0];
		}
			
	}
}