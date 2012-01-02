package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.commands.C_DrawFromSupplyToDiscard;
	import com.sillypog.dominion.engine.commands.C_MoveCard;
	import com.sillypog.dominion.engine.commands.C_PerformStep;
	import com.sillypog.dominion.engine.events.BuyEvent;
	import com.sillypog.dominion.engine.events.CardPlayEvent;
	import com.sillypog.dominion.engine.events.ChoiceEvent;
	import com.sillypog.dominion.engine.events.GameEvent;
	import com.sillypog.dominion.engine.events.TurnEvent;
	import com.sillypog.dominion.engine.piles.Pile;
	import com.sillypog.dominion.engine.piles.SupplyPile;
	import com.sillypog.dominion.engine.piles.player.PlayArea;
	import com.sillypog.dominion.engine.vo.BuyParameters;
	import com.sillypog.dominion.engine.vo.CardPlayParameters;
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
		
		public function Game(enforcer:SingletonEnforcer){}
		
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
			_currentPlayer = getPlayer('Next');
		}
		
		/**
		 * Called at the start of each player's turn
		 */
		public function beginTurn():void{
			_currentTurn = new Turn(_currentPlayer);
			_turns.push(_currentTurn);
			
			_currentTurn.addEventListener(TurnEvent.TURN_COMPLETE, turnComplete);
			
			_currentTurn.begin();
		}
		
		/**
		 * The application returns the same parameters object as was dispatched via choiceRequired.
		 * Now it has a result field saying which cards were chosen.
		 */
		public function choiceComplete(parameters:ChoiceParameters):Boolean{
			if (!parameters.result){
				_currentTurn.nextPhase();
				return false;
			}
			
			// Should maybe return a boolean based on whether result matches parameters
			if (!parameters.result.isType(parameters.cardType)){
				return false;
			}
			
			// Want to trigger commands based on what is in the choice parameters.
			// The consistent thing is that we will be the card from one pile (hand) to another (play area).
			var player:Player = parameters.player;
			var source:Pile = player.getPileByName(parameters.sourcePile);
			var destination:Pile = player.getPileByName(parameters.destinationPile);
			var moveCommand:C_MoveCard = new C_MoveCard(parameters.result, source, destination);
			moveCommand.execute();
			
			// Now we can continue the current turn
			_currentTurn.continueTurn();
			
			return true;
		}
		
		public function buyComplete(parameters:BuyParameters):Boolean{
			if (!parameters.purchase){
				_currentTurn.nextPhase();
				return false;
			}
			
			// Check if the purchase (ie there are cards to buy and player can meet conditions for purchase) is valid and return false if not
			var supplyPile:SupplyPile = SupplyPile(parameters.purchase);
			if (supplyPile.count == 0 || !supplyPile.purchasable(parameters)){
				return false
			}
			
			
			// Run commands to take the card from the supply and add to player deck
			var player:Player = parameters.player;
			var buyCommand:C_DrawFromSupplyToDiscard = new C_DrawFromSupplyToDiscard(supplyPile, player);
			buyCommand.execute();
			
			_currentTurn.continueTurn();
			
			return true;
		}
		
		/**
		 * When a player plays a card (ie, it enters the players playArea, the steps to perform are sent here.
		 */
		public function cardPlayed(e:CardPlayEvent):void{
			trace('Game: cardPlayed:',e.card.name);
			for (var i:int = 0, c:int = e.steps.length; i < c; i++){
				var stepCommand:C_PerformStep = new C_PerformStep(this,e.steps[i]);
				stepCommand.execute();
			}
		}
		
		public function getPlayer(key:String):Player{
			var requested:Player;
			switch(key){
				case 'Current': requested = _currentPlayer;
					break;
				case 'Next': var index:int = _players.indexOf(_currentPlayer);
							index++;
							if (index == _players.length){
								index = 0;
							}
							requested = _players[index];
			}
			return requested;
		}
		
		/**
		 * When a player must select something to do with cards, eg which cards in hand to play or
		 * which of an opponents cards to trash, it comes here. An event is sent out, allowing the
		 * display to permit the selection.
		 */
		internal function choiceRequired(parameters:ChoiceParameters):void{
			var choiceEvent:ChoiceEvent = new ChoiceEvent(ChoiceEvent.CHOOSE_FROM_PILE, parameters);
			dispatchEvent(choiceEvent);
		}
		
		internal function chooseBuy(parameters:BuyParameters):void{
			var buyEvent:BuyEvent = new BuyEvent(BuyEvent.CHOOSE_BUY, parameters);
			dispatchEvent(buyEvent);
		}
		
		private function turnComplete(e:Event):void{
			// Check if the game has been won
			var provincePile:Pile = _table.getPileByName('Province');
			var emptyPiles:Vector.<Pile> = _table.supply.emptyPiles;
			if (provincePile.count == 0 || emptyPiles.length >= 3){
				gameOver();
			} else {
				// Otherwise start next turn
				var turnEvent:Event = new Event(GameEvent.TURN_COMPLETE);
				dispatchEvent(e);
			}
		}
		
		private function gameOver():void{
			dispatchEvent(new Event(GameEvent.GAME_OVER));
		}
		
	}
}

class SingletonEnforcer{}