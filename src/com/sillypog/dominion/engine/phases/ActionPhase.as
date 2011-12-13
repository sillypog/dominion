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
		public function ActionPhase()
		{
		}
		
		public function get name():String
		{
			return null;
		}
		
		public function get nextPhase():IPhase{
			return new TreasurePhase();
		}
		
		public function play(turn:Turn, player:Player):void
		{
			// If the player has actions remaining...
			// Decrement the players actions
			
			
			// Allow player to choose action cards to play
			// If the player has no action cards to play, skip to the next phase
			var hand:Hand = Hand(player.getPileByName(PileNames.HAND));
			var actionCards:Vector.<Card> = hand.getCardsByType(CardType.ACTION);
			if (player.actionsRemaining < 1 || actionCards.length == 0){
				// End phase
				trace(player, 'can not continue ActionPhase.');
				turn.nextPhase();
				return;
			}
			
			// Choosing cards from a subset in the hand should be a generic thing because we'll have to do that for
			// treasures and reactions too.
			
			// Dispatch an event indicating a choice must be made and wait for that to happen
			
			// Make choice can have these params:
			// - Number of cards
			// - Type of cards
			
			// Don't have to skip this phase, the choice part can see that there were no choices made and return that nothing was selected.
			// But it is more efficient to skip it here, rather than involve the visual layer.
			
			// When a choice is made, the turn will play it's current phase, which is still this.
			// If we're out of actions we can tell the turn to advance to the next phase.
			
			
			var choiceRequirements:ChoiceParameters = new ChoiceParameters(player, 1, PileNames.HAND, CardType.ACTION);
			player.choiceRequired(choiceRequirements);
		}
		
		public function end():void{}
		
	}
}