package com.sillypog.dominion.engine.commands
{
	import com.sillypog.dominion.engine.vo.ChoiceParameters;

	/**
	 * When a choice of cards has been made, eg to play or to gain, 
	 * the result comes here so the cards can be transfered between piles 
	 * correctly.
	 */
	public class C_ResolveChoice implements ICommand
	{
		private var p:ChoiceParameters
		
		public function C_ResolveChoice(parameters:ChoiceParameters)
		{
			p = parameters
		}
		
		public function execute():void
		{
			
		}
	}
}