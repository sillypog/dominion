package com.sillypog.dominion.engine.vo
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