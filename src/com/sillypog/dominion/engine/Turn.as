package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.phases.ActionPhase;
	import com.sillypog.dominion.engine.phases.IPhase;

	public class Turn
	{
		private var _currentPlayer:Player;
		
		private var _currentPhase:IPhase
		
		public function Turn(currentPlayer:Player){
			_currentPlayer = currentPlayer;
		}
		
		public function begin():void{
			trace(_currentPlayer.name + ' beginning turn');
			
			_currentPhase = new ActionPhase();
			_currentPhase.play(this, _currentPlayer);
		}
		
	}
}