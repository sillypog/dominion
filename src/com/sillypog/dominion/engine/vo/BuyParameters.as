package com.sillypog.dominion.engine.vo
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.Pile;

	public class BuyParameters
	{
		private var _player:Player;
		private var _treasure:int;
		private var _playArea:Pile;
		
		private var _purchase:Pile;
		
		public function BuyParameters(player:Player, treasure:int, playArea:Pile)
		{
			_player = player;
			_treasure = treasure;
			_playArea = playArea;
		}
		
		public function get player():Player{
			return _player;
		}
		
		public function get treasure():int{
			return _treasure;
		}
		
		public function get playArea():Pile{
			return _playArea;
		}
		
		
		public function get purchase():Pile{
			return _purchase;
		}
		public function set purchase(value:Pile):void{
			_purchase = value;
		}
	}
}