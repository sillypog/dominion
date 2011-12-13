package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.IPileOwner;
	import com.sillypog.dominion.engine.piles.MixedPile;
	
	public class PlayerPile extends MixedPile
	{
		private var _name:String;
		
		public function PlayerPile(owner:IPileOwner){
			super(owner);
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
		public function addCards(cards:Vector.<Card>):void{
			_cards = _cards.concat(cards);
		}
		
		/**
		 * Takes all the cards off a pile.
		 * Use in combination with addCards to swap piles.
		 */
		public function removeAllCards():Vector.<Card>{
			var cards:Vector.<Card> = _cards.splice(0, _cards.length);
			return cards;
		}
		
		/**
		 * Unlike other piles, it will matter whether the requester owns this pile.
		 * If it is not the owner, return what is visible to the table.
		 */
		override public function showVisibleCards(requester:IPileOwner):Vector.<Card>{
			var visibleCards:Vector.<Card>;
			if (requester == owner){
				visibleCards = new Vector.<Card>();
				var len:int = 0;
				switch(playerVisibility){
					case this.VISIBILITY_TOP: len = 1;
						break;
					case this.VISIBILITY_ALL: len = count;
						break;
				}
				for (var i:int = count-len; i < count; i++){
					visibleCards.push(_cards[i]);
				}
			} else {
				visibleCards = super.showVisibleCards(requester);
			}
			return visibleCards;
		}
	}
}