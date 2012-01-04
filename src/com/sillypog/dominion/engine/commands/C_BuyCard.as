package com.sillypog.dominion.engine.commands
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.SupplyPile;
	import com.sillypog.dominion.engine.vo.PlayerTurnProperties;

	public class C_BuyCard implements ICommand
	{
		private var _supplyPile:SupplyPile;
		private var _player:Player;
		
		public function C_BuyCard(supplyPile:SupplyPile, player:Player)
		{
			_supplyPile = supplyPile;
			_player = player;
		}
		
		public function execute():void
		{
			var supplyCard:Card = _supplyPile.showVisibleCards(null)[0];
			var cost:int = supplyCard.cost.treasure;
			
			var drawCommand:C_DrawFromSupplyToDiscard = new C_DrawFromSupplyToDiscard(_supplyPile, _player);
			drawCommand.execute();
			
			var treasureCommand:C_ChangePlayerProperty = new C_ChangePlayerProperty(_player, PlayerTurnProperties.TREASURE, -cost);
			treasureCommand.execute();
		}
	}
}