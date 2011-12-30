package com.sillypog.dominion.engine.phases
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.Turn;
	import com.sillypog.dominion.engine.commands.C_PlayerDrawCards;
	import com.sillypog.dominion.engine.commands.C_TransferPlayerPile;
	import com.sillypog.dominion.engine.piles.player.Discard;
	import com.sillypog.dominion.engine.piles.player.Hand;
	import com.sillypog.dominion.engine.piles.player.PileNames;
	import com.sillypog.dominion.engine.piles.player.PlayerPile;

	public class CleanupPhase implements IPhase
	{
		private var _turn:Turn;
		private var _player:Player;
		
		private var _played:Boolean;
		
		public function CleanupPhase(turn:Turn, player:Player)
		{
			_turn = turn;
			_player = player;
		}
		
		public function get name():String
		{
			return 'Cleanup Phase';
		}
		
		public function get nextPhase():IPhase{
			return null;	// This way completed turns will not carry an unused phase with them
		}
		
		public function get playable():Boolean{
			return !_played;
		}
		
		public function play():void
		{
			_played = true;
			_player.turnProperties.reset();
			
			var numDraw:int = 5;	// Number of cards to draw into new hand.
			// Check through the playArea and run anything that should happen in clean up
			// May modifiy numDraw
			
			// Move all the cards to discard
			var transferCommand:C_TransferPlayerPile = new C_TransferPlayerPile(_player, PileNames.PLAY_AREA, PileNames.DISCARD);
			transferCommand.execute();
			
			transferCommand.source = PileNames.HAND;
			transferCommand.execute();
			
			// Draw a new hand
			var drawCommand:C_PlayerDrawCards = new C_PlayerDrawCards(_player, numDraw); 
			drawCommand.execute();
			
			_turn.continueTurn();
		}
		
		public function end():void{}
	}
}