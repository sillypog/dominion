package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.events.TurnEvent;
	import com.sillypog.dominion.engine.phases.ActionPhase;
	import com.sillypog.dominion.engine.phases.IPhase;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class Turn extends EventDispatcher
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
		
		public function continueTurn():void{
			if (_currentPhase.playable){
				_currentPhase.play();
			} else {
				trace(_currentPhase.name,'complete');
				nextPhase();
			}
		}
		
		public function nextPhase():void{
			_currentPhase.end();
			
			_currentPhase = _currentPhase.nextPhase;
			
			if (_currentPhase){
				continueTurn();
			} else {
				trace('Turn complete');
				var completeEvent:Event = new Event(TurnEvent.TURN_COMPLETE);
				dispatchEvent(completeEvent);
			}
		}
		
	}
}