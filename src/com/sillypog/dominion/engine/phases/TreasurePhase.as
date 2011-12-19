package com.sillypog.dominion.engine.phases
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.Turn;
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.cards.CardType;
	import com.sillypog.dominion.engine.piles.player.Hand;
	import com.sillypog.dominion.engine.piles.player.PileNames;
	import com.sillypog.dominion.engine.vo.ChoiceParameters;

	public class TreasurePhase implements IPhase
	{
		private var _turn:Turn;
		private var _player:Player;
		
		public function TreasurePhase(turn:Turn, player:Player)
		{
			_turn = turn;
			_player = player;
		}
		
		/**
		 * @return Treasure Phase
		 */
		public function get name():String
		{
			return 'Treasure Phase';
		}
		
		/**
		 * @return Instance of BuyPhase
		 */
		public function get nextPhase():IPhase{
			//return new BuyPhase();
			return null;
		}
		
		/**
		 * Phase is playable if the following are true:
		 *  - Player's hand contains treasure cards.
		 */
		public function get playable():Boolean{
			var hand:Hand = Hand(_player.getPileByName(PileNames.HAND));
			var treasures:Vector.<Card> = hand.getCardsByType(CardType.TREASURE);
			var playable:Boolean;
			if (treasures.length > 0){
				playable = true;
			}
			
			return playable;
		}
		
		public function play():void
		{
			// Select currency cards to put into the play area.
			// During Buy phase, the total played can be used to purchase things
			
			// Should this phase be separate from Buy? If you have multiple buys, do you have to put all your treasures out first?
			// That is how it is on the .NET version.
			
			// If the card is a duration card, it should be sent to the duration pile, not play area.
			// Perhaps this shouldn't specify the destination pile, more the action of what's happening (eg play(could be playArea or trash, etc)
			// There should be an outcome, and that is the name of the command to call.
			// Other choices could use the same thing.
			var choiceRequirements:ChoiceParameters = new ChoiceParameters(_player, PileNames.HAND, PileNames.PLAY_AREA, CardType.TREASURE);
			_player.choiceRequired(choiceRequirements);
		}
		
		public function end():void{
			trace('Treasure Phase end');
		}
	}
}