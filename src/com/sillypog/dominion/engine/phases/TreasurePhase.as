package com.sillypog.dominion.engine.phases
{
	import com.sillypog.dominion.engine.Player;

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
			return new BuyPhase();
		}
		
		public function play(player:Player):void
		{
		}
	}
}