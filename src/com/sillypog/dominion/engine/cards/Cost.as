package com.sillypog.dominion.engine.cards
{
	public class Cost
	{
		private var _treasure:uint;
		private var _potion:uint;
		
		public function Cost(description:XML){
			_treasure = description.treasure;
			_potion = description.potion;
		}
		
		
	}
}