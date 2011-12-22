package com.sillypog.dominion.engine.phases
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.Turn;
	import com.sillypog.dominion.engine.vo.Cost;
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
			return 'Buy Phase';
		}
		
		public function get nextPhase():IPhase{
			return new CleanupPhase(_turn, _player);
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
			var turnProperties:PlayerTurnProperties = _player.turnProperties;
			turnProperties.change(PlayerTurnProperties.BUYS, -1);
			
			// Choose a card from the supply that they can currently afford.
			// Whether they can afford it can be determined by building a Cost object and letting them work it out between each other
			
			// Grand Market requires that there are no coppers in PlayArea. So maybe it is easier to send the playArea than the
			// properties and let the cards inspect it to see if the player can afford it.
			
			
			
		}
		
		public function end():void{}
	}
}