package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.player.Deck;
	import com.sillypog.dominion.engine.piles.player.Discard;
	import com.sillypog.dominion.engine.piles.player.Hand;
	import com.sillypog.dominion.engine.piles.player.PlayArea;
	

	public class Player
	{
		private var _name:String;
		
		private var _deck:Deck;
		private var _hand:Hand;
		private var _playArea:PlayArea;
		private var _discard:Discard;
		// set aside
		// duration
		
		public function Player(){
			_deck = new Deck();
			_hand = new Hand();
			_playArea = new PlayArea();
			_discard = new Discard();
		}
		
		public function get name():String{
			return _name;
		}
		public function set name(value:String):void{
			_name = value;
		}
		
		/**
		 * Adds a card to the discard pile.
		 */
		public function toDiscard(card:Card):void{
			_discard.add(card);
		}
		
	}
}