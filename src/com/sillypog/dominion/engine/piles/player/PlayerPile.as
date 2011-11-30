package com.sillypog.dominion.engine.piles.player
{
	import com.sillypog.dominion.engine.piles.MixedPile;
	
	public class PlayerPile extends MixedPile
	{
		private var _name:String;
		
		public function PlayerPile(){
			super();
		}
		
		public function get name():String{
			return _name;
		}
		public function set name(value:String):void{
			_name = value;
		}
	}
}