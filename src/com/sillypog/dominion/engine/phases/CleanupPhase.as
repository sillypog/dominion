package com.sillypog.dominion.engine.phases
{
	import com.sillypog.dominion.engine.Player;

	public class CleanupPhase implements IPhase
	{
		public function CleanupPhase()
		{
		}
		
		public function get name():String
		{
			return null;
		}
		
		public function get nextPhase():IPhase{
			return null;	// This way completed turns will not carry an unused phase with them
		}
		
		public function play(player:Player):void
		{
		}
	}
}