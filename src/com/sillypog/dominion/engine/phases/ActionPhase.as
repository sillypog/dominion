package com.sillypog.dominion.engine.phases
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.Turn;
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.cards.CardType;
	import com.sillypog.dominion.engine.piles.player.Hand;
	import com.sillypog.dominion.engine.piles.player.PileNames;
	import com.sillypog.dominion.engine.vo.ChoiceParameters;

	public class ActionPhase implements IPhase
	{
		private var _turn:Turn;
		private var _player:Player;
		
		public function ActionPhase(turn:Turn, player:Player)
		{
			_turn = turn;
			_player = player;
		}
		
		public function get name():String
		{
			return 'Action Phase';
		}
		
		/**
		 * @return Instance of TreasurePhase
		 */
		public function get nextPhase():IPhase{
			return new TreasurePhase(_turn, _player);
		}
		
		/**
		 * Phase is playable if the following are true:
		 *  - player has actions remaining.
		 *  - player's hand contains action cards.
		 */
		public function get playable():Boolean{
			var hand:Hand = Hand(_player.getPileByName(PileNames.HAND));
			var actionCards:Vector.<Card> = hand.getCardsByType(CardType.ACTION);
			var playable:Boolean;
			if (_player.actionsRemaining > 0 && actionCards.length > 0){
				playable = true;
			}
			
			return playable;
		}
		
		public function play():void
		{
			// Decrement the players actions
		
			// Allow player to choose action cards to play
	
			// Choosing cards from a subset in the hand should be a generic thing because we'll have to do that for
			// treasures and reactions too.
			
			// Dispatch an event indicating a choice must be made and wait for that to happen
			
			// Make choice can have these params:
			// - Number of cards
			// - Type of cards
			
			// When a choice is made, the turn will play it's current phase, which is still this.
			// If we're out of actions we can tell the turn to advance to the next phase.
			
			
			var choiceRequirements:ChoiceParameters = new ChoiceParameters(_player, PileNames.HAND, PileNames.PLAY_AREA, CardType.ACTION);
			_player.choiceRequired(choiceRequirements);
		}
		
		public function end():void{}
		
	}
}