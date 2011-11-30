package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.piles.MixedPile;
	
	public class PlayerPile extends MixedPile
	{
		private var _name:String;
		
		public function PlayerPile(){
			super();
		}
		
		public function get name():String{
			return _name;
		}
		public function set name(value:String):void{
			_name = value;
		}
		
		/**
		 * Adds several cards at once to the top of a pile.
		 * Use in combination with addCards to swap piles.
		 */
		public function addCards(cards:Vector.<String>):void{
			_cards = _cards.concat(cards);
		}
		
		/**
		 * Takes all the cards off a pile.
		 * Use in combination with addCards to swap piles.
		 */
		public function removeAllCards():Vector.<String>{
			var cards:Vector.<String> = _cards.splice(0, _cards.length);
			return cards;
		}
	}
}