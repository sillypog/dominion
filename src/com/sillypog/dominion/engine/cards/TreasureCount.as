package com.sillypog.dominion.engine.cards
{
	import flash.utils.Dictionary;


	public class TreasureCount{
		
		public const COPPER:String = 'Copper';
		public const SILVER:String = 'Silver';
		public const GOLD:String = 'Gold';
	
		private var _counts:Dictionary;
		
		public function TreasureCount()
		{
			_counts = new Dictionary();
			_counts[COPPER] = 60;
			_counts[SILVER] = 40;
			_counts[GOLD] = 30;
		}
		
		public function getCounts(denomination:String):uint{
			return _counts[denomination];
		}
	}
}