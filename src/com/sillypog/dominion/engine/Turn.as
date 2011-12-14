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
			
			_currentPhase = new ActionPhase(this, _currentPlayer);
			
			continueTurn();
		}
		
		private function continueTurn():void{
			if (_currentPhase.playable){
				_currentPhase.play();
			} else {
				trace(_currentPhase.name,'complete');
				nextPhase();
			}
		}
		
		private function nextPhase():void{
			_currentPhase.end();
			
			_currentPhase = _currentPhase.nextPhase;
			_currentPhase.play();
		}
		
	}
}