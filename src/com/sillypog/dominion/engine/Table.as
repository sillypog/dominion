package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.cards.CardType;
	import com.sillypog.dominion.engine.cards.KingdomCard;
	import com.sillypog.dominion.engine.cards.TreasureCount;
	import com.sillypog.dominion.engine.commands.C_DealToPlayer;
	import com.sillypog.dominion.engine.piles.IPileOwner;
	import com.sillypog.dominion.engine.piles.Pile;
	import com.sillypog.dominion.engine.piles.SupplyPile;
	import com.sillypog.dominion.engine.piles.Trash;

	/**
	 * Manages supply, mats, Players.
	 */
	public class Table implements IPileOwner
	{
		private static var _table:Table;
		
		private var _supply:Supply;
		private var _trash:Trash; 
		
		public function Table(enforcer:SingletonEnforcer){}
		
		public static function get instance():Table{
			if (!_table){
				_table = new Table(new SingletonEnforcer());
			}
			return _table;
		}
		
		/**
		 * Visual interface can use this to get all the supply piles in order
		 * to display Card details and counts.
		 */
		public function get supply():Supply{
			return _supply;
		}
		
		/**
		 * Supply is created with the full number of cards. 
		 * When players' initial hands are dealt, draw from the relevant piles (ie Copper and Estate).
		 */
		public function createSupply(universalCards:Vector.<Card>, kingdomCards:Vector.<KingdomCard>, numPlayers:int):void{
			_supply = Supply.instance;
			
			var treasureCount:TreasureCount = new TreasureCount();
			var cardCount:int = 10;
			var pile:SupplyPile;
			var card:Card;
			
			for (var i:int = 0; i < universalCards.length; i++) {
				card = universalCards[i];
				cardCount = 10;
				if (card.isType(CardType.VICTORY)){
					cardCount = numPlayers > 2 ? 12 : 8;
					if (card.name == 'Estate'){
						cardCount += 3 * numPlayers;
					}
				} else if (card.isType(CardType.CURSE)){
					cardCount = 10 + (numPlayers-1)*10;
				} else if (card.isType(CardType.TREASURE)){
					cardCount = treasureCount.getCounts(card.name);
				}
				_supply.createUniversalPile(card, cardCount);
			}
			
			
			for (i = 0; i < kingdomCards.length; i++){
				card = kingdomCards[i];
				cardCount = 10;
				if (card.isType(CardType.VICTORY)){
					cardCount = numPlayers > 2 ? 12 : 8;
				}
				_supply.createKingdomPile(card, cardCount);
			}
			
			// Also add the trash pile
			_trash = new Trash(this);
		}
		
		/**
		 * At the beginning of a game, a player is added to the table through this function.
		 * Players decks and mats can be created here.
		 */
		public function seatPlayer(player:Player):void{
			// Want to draw the 7 copper and 3 estates. Can I set up a command system for this and make this a macro command?
			var dealCommand:C_DealToPlayer = new C_DealToPlayer(player, SupplyPile(_supply.getPileByName('Copper')), SupplyPile(_supply.getPileByName('Estate')));
			dealCommand.execute();
		}
		
		public function getPileByName(pileName:String):Pile{
			var pile:Pile = _supply.getPileByName(pileName);
			if (!pile){
				pile = _trash;
			}
			return pile;	// TO DO
		}
	}
}

/**
 * Ensures that Constructor can only be run from static function of Game
 */
class SingletonEnforcer{
	public function SingletonEnforcer(){}
}