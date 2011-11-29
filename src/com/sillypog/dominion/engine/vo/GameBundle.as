package com.sillypog.dominion.engine.vo
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.cards.KingdomCard;
	
	/**
	 * When a new game is created, the parameters (eg number of players, kingdom cards) are described here.
	 * Game will use this to setup.
	 */
	public class GameBundle
	{
		private var _players:Vector.<Player>;
		private var _universalCards:Vector.<Card>;
		private var _kingdomCards:Vector.<KingdomCard>;
		
		public function GameBundle(players:Vector.<Player>, universalCards:Vector.<Card>, kingdomCards:Vector.<KingdomCard>){
			_players = players;
			_kingdomCards = kingdomCards;
			_universalCards = universalCards;
		}
		
		public function get numPlayers():uint{
			return _players.length;
		}
		
		public function get players():Vector.<Player>{
			return _players;
		}
		
		public function get universalCards():Vector.<Card>{
			return _universalCards;
		}
		
		public function get kingdomCards():Vector.<KingdomCard>{
			return _kingdomCards;
		}
	}
}