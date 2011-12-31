package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.IPileOwner;
	import com.sillypog.dominion.engine.piles.Pile;
	import com.sillypog.dominion.engine.piles.SupplyPile;
	
	import flash.utils.Dictionary;
	
	/**
	 * All of the piles on the table that aren't associated with a Player.
	 * Eg, Kingdom Cards, Treasure.
	 * 
	 * Trash is not included in the supply.
	 * 
	 * Singleton class.
	 */
	public class Supply implements IPileOwner{
		
		private static var _instance:Supply;
		
		private var _piles:Vector.<SupplyPile>;
		private var _pileLookup:Dictionary;
		
		private var _kingdomPiles:Vector.<Pile>;
		private var _universalPiles:Vector.<Pile>;
		
		public static function get instance():Supply{
			if (!_instance){
				_instance = new Supply(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function Supply(enforcer:SingletonEnforcer){
			_piles = new Vector.<SupplyPile>();
			_kingdomPiles = new Vector.<Pile>();
			_universalPiles = new Vector.<Pile>();
			
			_pileLookup = new Dictionary();
		}
		
		public function createUniversalPile(cardType:Card, startingNumber:int):void{
			var pile:SupplyPile = createPile(cardType, startingNumber);
			_universalPiles.push(pile);
		}
		
		public function createKingdomPile(cardType:Card, startingNumber:int):void{
			var pile:SupplyPile = createPile(cardType, startingNumber);
			_kingdomPiles.push(pile);
		}
		
		/**
		 * When Young Witch is in play, another pile is added to the supply that is the special Bane pile.
		 */
		public function addBanePile(pile:SupplyPile):void{
			// To do
		}
		
		public function getPileByName(name:String):Pile{
			return _pileLookup[name];
		}
		
		public function kingdomPiles():Vector.<Pile>{
			return _kingdomPiles;
		}
		
		public function universalPiles():Vector.<Pile>{
			return _universalPiles;
		}
		
		public function get emptyPiles():Vector.<Pile>{
			var empties:Vector.<Pile> = new Vector.<Pile>();
			for (var i:int = 0, c:int = _piles.length; i < c; i++){
				var pile:Pile = _piles[i];
				if (pile.count == 0){
					empties.push(pile);
				}
			}
			return empties;
		}
		
		/**
		 * Piles in the supply all contain the same type of card.
		 */
		private function createPile(cardType:Card, startingNumber:int):SupplyPile{
			var pile:SupplyPile = new SupplyPile(this, cardType, startingNumber);
			
			_piles.push(pile);
			_pileLookup[cardType.name] = pile;
			
			return pile;
		}
	}	
}

class SingletonEnforcer{}