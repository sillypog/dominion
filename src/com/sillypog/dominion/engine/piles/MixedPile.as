package com.sillypog.dominion.engine.piles
{
	import com.sillypog.dominion.engine.cards.Card;
	
	import flash.utils.Dictionary;

	public class MixedPile extends Pile
	{
		/**
		 * Contains all the Card objects available in the game so that they can be retrieved by name.
		 * This is because cards are stored by name rather than keeping all the objects.
		 */
		private static var cardLookup:Dictionary;
		
		/**
		 * Cards are stored by name. This avoids accumulating hundreds of Card objects as the game progresses.
		 */
		protected var _cards:Vector.<String>;
		
		/**
		 * Copied from static variable in constructor.
		 */
		private var _cardLookup:Dictionary;
		
		public static function setCardLookup(dictionary:Dictionary):void{
			cardLookup = dictionary;
		}
		
		public function MixedPile(){
			super();
			_cards = new Vector.<String>();
			_cardLookup = MixedPile.cardLookup;
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
			var card:Card = _cardLookup[cardName];
			return card.clone();	
		}
		
		
		
		
	}
}