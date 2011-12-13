package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.events.ChoiceEvent;
	import com.sillypog.dominion.engine.events.GameEvent;
	import com.sillypog.dominion.engine.vo.ChoiceParameters;
	import com.sillypog.dominion.engine.vo.GameBundle;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * Organises Players and Stacks.
	 * Manages turns and handles major game events, eg start and end.
	 * 
	 * Singleton class.
	 */
	public class Game extends EventDispatcher
	{
		private static var _instance:Game;
		
		private var _table:Table;
		
		private var _players:Vector.<Player>;
		private var _currentPlayer:Player;
		
		private var _turns:Vector.<Turn>;
		private var _currentTurn:Turn;
			
		public static function get instance():Game{
			if (!_instance){
				_instance = new Game(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function Game(enforcer:SingletonEnforcer){
			
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
			dispatchEvent(new Event(GameEvent.GAME_READY));
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
		
		/**
		 * When a player must select something to do with cards, eg which cards in hand to play or
		 * which of an opponents cards to trash, it comes here. An event is sent out, allowing the
		 * display to permit the selection.
		 */
		public function choiceRequired(requirements:ChoiceParameters):void{
			var choiceEvent:ChoiceEvent = new ChoiceEvent(ChoiceEvent.CHOICE_REQUIRED, requirements);
			dispatchEvent(choiceEvent);
		}
		
		
		
	}
}

class SingletonEnforcer{}

