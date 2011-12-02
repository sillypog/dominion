package com.sillypog.dominion.engine.phases
{
	import com.sillypog.dominion.engine.Player;

	public class BuyPhase implements IPhase
	{
		public function BuyPhase()
		{
		}
		
		public function get name():String
		{
			return null;
		}
		
		public function get nextPhase():IPhase{
			return new CleanupPhase();
		}
		
		public function play(player:Player):void
		{
		}
	}
}