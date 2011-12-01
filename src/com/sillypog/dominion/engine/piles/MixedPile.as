package com.sillypog.dominion.engine.piles
{
	import com.sillypog.dominion.engine.cards.Card;
	
	public class MixedPile extends Pile
	{		
		/**
		 * Cards are stored as references to the Card object in supply piles.
		 */
		protected var _cards:Vector.<Card>;
		
		public function MixedPile(){
			super();
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
			return _cards.pop();	
		}
			
	}
}