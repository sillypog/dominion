package com.sillypog.dominion.engine.commands
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.SupplyPile;

	/**
	 * This is the standard way a player takes a card from the supply.
	 * The card is added to the player's discard pile.
	 */
	public class C_DrawFromSupplyToDiscard implements ICommand
	{
		private var _supplyPile:SupplyPile;
		private var _player:Player;
		
		public function C_DrawFromSupplyToDiscard(supplyPile:SupplyPile, player:Player){
			_supplyPile = supplyPile;
			_player = player;
		}
		
		public function execute():void{
			var card:Card = _supplyPile.draw();
			_player.toDiscard(card);
		}
		
	}
}