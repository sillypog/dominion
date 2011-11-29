package com.sillypog.dominion.engine.piles
{
	import com.sillypog.dominion.engine.cards.Card;

	public class MixedPile extends Pile
	{
		/**
		 * Cards are stored by name. This avoids accumulating hundreds of Card objects as the game progresses.
		 */
		private var _cards:Vector.<String>;
		
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
		
		
	}
}