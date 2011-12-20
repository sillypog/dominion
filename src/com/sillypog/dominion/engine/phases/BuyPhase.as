package com.sillypog.dominion.engine.phases
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.Turn;
	import com.sillypog.dominion.engine.vo.PlayerTurnProperties;

	public class BuyPhase implements IPhase
	{
		private var _turn:Turn;
		private var _player:Player;
		
		public function BuyPhase(turn:Turn, player:Player)
		{
			_turn = turn;
			_player = player;
		}
		
		public function get name():String
		{
			return null;
		}
		
		public function get nextPhase():IPhase{
			return null;
			//return new CleanupPhase();
		}
		
		/**
		 * Phase is playable if the following are true:
		 *  - Player has treasure.
		 *  - Player has buys.
		 */
		public function get playable():Boolean{
			var turnProperties:PlayerTurnProperties = _player.turnProperties;
			var buys:int = turnProperties.retrieve(PlayerTurnProperties.BUYS);
			var treasures:int = turnProperties.retrieve(PlayerTurnProperties.TREASURE);
			
			var playable:Boolean;
			if (buys && treasures){
				playable = true;
			}
			return playable;
			
		}
		
		public function play():void
		{
		}
		
		public function end():void{}
	}
}