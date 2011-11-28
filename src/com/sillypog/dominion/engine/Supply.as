package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.piles.SupplyPile;
	
	/**
	 * All of the piles on the table that aren't associated with a Player.
	 * Eg, Kingdom Cards, Treasure.
	 * 
	 * Trash is not included in the supply.
	 * 
	 * Singleton class.
	 */
	public class Supply{
		
		private static var _instance:Supply;
		
		private var _piles:Vector.<SupplyPile>;
		
		public static function get instance():Supply{
			if (!_instance){
				_instance = new Supply(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function Supply(enforcer:SingletonEnforcer){
			_piles = new Vector.<SupplyPile>;
		}
		
		/**
		 * Piles in the supply all contain the same type of card.
		 */
		public function addPile(pile:SupplyPile):void{
			_piles.push(pile);
		}
		
		/**
		 * When Young Witch is in play, another pile is added to the supply that is the special Bane pile.
		 */
		public function addBanePile(pile:SupplyPile):void{
			// To do
		}
	}	
}

class SingletonEnforcer{}