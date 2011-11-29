package com.sillypog.dominion.engine.commands
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.piles.SupplyPile;

	/**
	 * Deals players their initial hand of 7 Copper and 3 Estates.
	 */
	public class C_DealToPlayer implements ICommand
	{
		private const NUM_COPPER:uint = 7;
		private const NUM_ESTATE:uint = 3;
		
		private var _player:Player;
		private var _copperPile:SupplyPile;
		private var _estatePile:SupplyPile;
		
		public function C_DealToPlayer(player:Player, copperPile:SupplyPile, estatePile:SupplyPile){
			_player = player;
			_copperPile = copperPile;
			_estatePile = estatePile;
		}
		
		public function execute():void{
			var dealCopperCommand:C_DrawFromSupplyToDiscard = new C_DrawFromSupplyToDiscard(_copperPile, _player);
			for (var i:int = 0; i < NUM_COPPER; i++){
				dealCopperCommand.execute();
			}
			
			var dealEstateCommand:C_DrawFromSupplyToDiscard = new C_DrawFromSupplyToDiscard(_estatePile, _player);
			for (i = 0; i < NUM_ESTATE; i++){
				dealEstateCommand.execute();
			}
		}
		
	}
}