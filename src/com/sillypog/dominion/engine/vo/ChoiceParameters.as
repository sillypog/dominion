package com.sillypog.dominion.engine.vo
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.cards.Card;

	public class ChoiceParameters
	{
		private var _player:Player;
		private var _sourcePile:String;
		private var _destinationPile:String;
		private var _cardType:String;
		
		private var _result:Card;
		
		public function ChoiceParameters(player:Player, sourcePile:String, destinationPile:String, cardType:String){
			_player = player;
			_sourcePile = sourcePile;
			_destinationPile = destinationPile;
			_cardType = cardType;
		}
		
		public function get player():Player{
			return _player;
		}
		
		public function get sourcePile():String{
			return _sourcePile;
		}
		
		public function get destinationPile():String{
			return _destinationPile;
		}
		
		public function get cardType():String{
			return _cardType;
		}
		
		public function get result():Card{
			return _result;
		}
		public function set result(value:Card):void{
			_result = value;
		}
	}
}