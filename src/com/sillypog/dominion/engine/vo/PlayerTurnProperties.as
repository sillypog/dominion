package com.sillypog.dominion.engine.vo
{
	import flash.utils.Dictionary;

	public class PlayerTurnProperties
	{
		public static const ACTIONS:String = 'Actions';
		public static const TREASURE:String = 'Treasure';
		public static const BUYS:String = 'Buys';
		
		private var dictionary:Dictionary;
		
		public function PlayerTurnProperties()
		{
			dictionary = new Dictionary();
			dictionary[ACTIONS] = 0;
			dictionary[TREASURE] = 0;
			dictionary[BUYS] = 0;
		}
		
		public function change(key:String, amount:int):int{
			dictionary[key] += amount;
			return dictionary[key];
		}
		
		public function retrieve(key:String):int{
			return dictionary[key];
		}
	}
}