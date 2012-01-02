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
		
		public function met(treasure:uint, potion:uint = 0):Boolean{
			var result:Boolean;
			if (treasure >= _treasure && potion >= _potion){
				result = true;
			}
			return result;
		}
		
		
	}
}