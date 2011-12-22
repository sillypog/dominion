package com.sillypog.dominion.engine.phases
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.Turn;

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
			
			// Check through the playArea and run anything that should happen in clean up
			
			_turn.continueTurn();
		}
		
		public function end():void{}
	}
}