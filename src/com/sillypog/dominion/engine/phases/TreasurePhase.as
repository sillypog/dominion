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
		public function TreasurePhase()
		{
		}
		
		public function get name():String
		{
			return null;
		}
		
		public function get nextPhase():IPhase{
			//return new BuyPhase();
			return null;
		}
		
		public function play(turn:Turn, player:Player):void
		{
			// Select currency cards to put into the play area.
			// During Buy phase, the total played can be used to purchase things
			
			// Should this phase be separate from Buy? If you have multiple buys, do you have to put all your treasures out first?
			// That is how it is on the .NET version.
			
			var hand:Hand = Hand(player.getPileByName(PileNames.HAND));
			var treasures:Vector.<Card> = hand.getCardsByType(CardType.TREASURE);
			if (treasures.length == 0){
				turn.nextPhase();
			}
			var choiceRequirements:ChoiceParameters = new ChoiceParameters(player, 0, PileNames.HAND, CardType.TREASURE);
			player.choiceRequired(choiceRequirements);
		}
		
		public function end():void{
			
		}
	}
}