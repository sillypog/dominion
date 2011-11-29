package com.sillypog.dominion.engine.piles
{
	import com.sillypog.dominion.engine.cards.Card;

	/**
	 * Base class for any pile of cards in the game, eg Kingdom cards in supply or a players draw deck.
	 * 
	 * Should be treated as an abstract class because piles with all the same cards should be SupplyPile;
	 * piles with different cards are MixedPile.
	 */
	public class Pile
	{
		protected const VISIBILITY_NONE:uint = 1;
		protected const VISIBILITY_TOP:uint = 2;
		protected const VISIBILITY_ALL:uint = 3;
		
		private var _tableVisibility:uint;
		private var _playerVisibility:uint;
		
		/**
		 * How this pile is visible to an individual player.
		 * Automatically returns the tableVisibility if it hasn't been overridden by a specific playerVisibility.
		 */
		public function get playerVisibility():uint{
			if (!_playerVisibility){
				return _tableVisibility;
			}
			return _playerVisibility;
		}
		public function set playerVisibility(value:uint):void{
			_playerVisibility = value;
		}
		
		/**
		 * How this pile is visible to all players at the table.
		 */
		public function get tableVisibility():uint{
			return _tableVisibility;
		}
		public function set tableVisibility(value:uint):void{
			_tableVisibility = value;
		}
		
		public function Pile(){}
		
		/**
		 * The number of cards in the pile.
		 */
		public function get count():int{
			return 0;
		}
		
		/**
		 * Adds a card to the top of the pile.
		 */
		public function add(card:Card):void{
			throw new Error('Abstract Method');
		}
		
		/**
		 * Removes a card from the top of the pile.
		 */
		public function draw():Card{
			throw new Error('Abstract Method');
		}
		
		
		
	}
}