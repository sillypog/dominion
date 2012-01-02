package com.sillypog.dominion.engine.commands
{
	import com.sillypog.dominion.engine.Game;
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.vo.CardPlayParameters;

	public class C_PerformStep implements ICommand
	{
		private var _game:Game;
		private var _step:CardPlayParameters;
		
		public function C_PerformStep(game:Game, step:CardPlayParameters)
		{
			_game = game;
			_step = step;
		}
		
		public function execute():void
		{
			// Get player to affect
			var player:Player = _game.getPlayer(_step.affects);
			
			// Find out what type of effect it is
			var stepCommand:ICommand;
			switch(_step.type){
				case 'Change': stepCommand = new C_ChangePlayerProperty(player, _step.property, _step.amount);
					break;
				case 'Draw': stepCommand = new C_PlayerDrawCards(player, _step.amount);
			}
			
			stepCommand.execute();
		}
	}
}