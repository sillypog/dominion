package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.piles.IPileOwner;
	import com.sillypog.dominion.engine.piles.Pile;

	/**
	 * Some card combinations mean that players get mats to put cards on.
	 * Ideally, the behaviour can come from the xml so new mats can be added with new cards.
	 * 
	 * The Mat has a pile on it where the cards go. But Pirate Ship uses tokens instead.
	 */
	public class Mat implements IPileOwner
	{
		private var _pile:Pile;
		
		public function Mat()
		{
		}
		
		public function getPileByName(pileName:String):Pile{
			return _pile;
		}
	}
}