package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.events.GameEvent;
	import com.sillypog.dominion.engine.vo.GameBundle;
	import com.sillypog.events.GlobalDispatcher;
	
	import flash.events.Event;
	
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
		private var _currentPlayer:Player;
		
		private var _turns:Vector.<Turn>;
		private var _currentTurn:Turn;
		
		private var dispatcher:GlobalDispatcher;
			
		public static function get instance():Game{
			if (!_instance){
				_instance = new Game(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function Game(enforcer:SingletonEnforcer){
			dispatcher = GlobalDispatcher.instance;
		}
		
		/**
		 * Call this to create a game with the provided cards and players.
		 * When the set up is ready, a GameEvent.GAME_READY is dispatched.
		 */
		public function newGame(bundle:GameBundle):void{
			trace('Game: newGame', bundle.kingdomCards);
			
			_table = Table.instance;
			_table.createSupply(bundle.universalCards, bundle.kingdomCards, bundle.numPlayers);
			
			_players = bundle.players;
			
			for (var i:int = 0; i < _players.length; i++) {
				_table.seatPlayer(_players[i]);
			}
			trace(_players.length,'Players seated');
			// Player 1 can now begin turn
			_currentPlayer = _players[0];
			
			_turns = new Vector.<Turn>();
			
			// Game display can be updated with complete table.
			dispatcher.dispatchEvent(new Event(GameEvent.GAME_READY));
			
			
		}
		
		/**
		 * Switch to the next player
		 */
		public function nextPlayer():void{
			
		}
		
		/**
		 * Called at the start of each player's turn
		 */
		public function beginTurn():void{
			_currentTurn = new Turn(_currentPlayer);
			_turns.push(_currentTurn);
			
			_currentTurn.begin();
		}
		
		
		
	}
}

class SingletonEnforcer{}

