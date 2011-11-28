package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.vo.GameBundle;
	
	/**
	 * Organises Players and Stacks.
	 * Manages turns and handles major game events, eg start and end.
	 * 
	 * Singleton class.
	 */
	public class Game
	{
		private static var _instance:Game;
		
		private var _table:Table;
		private var _players:Vector.<Player>;
			
		public static function get instance():Game{
			if (!_instance){
				_instance = new Game(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function Game(enforcer:SingletonEnforcer){}
			
		public function newGame(bundle:GameBundle):void{
			trace('Game: newGame', bundle.kingdomCards);
			
			_table = Table.instance;
			_table.createSupply(bundle.universalCards, bundle.kingdomCards, bundle.numPlayers);
			
			_players = bundle.players;
			
			for (var i:int = 0; i < _players.length; i++) {
				_table.seatPlayer(_players[i]);
			}
			
		}
		
	}
}

class SingletonEnforcer{}

