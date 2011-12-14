package com.sillypog.dominion.engine.vo
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.cards.Card;

	public class ChoiceParameters
	{
		private var _player:Player;
		private var _numCards:int;
		private var _fromDeck:String;
		private var _cardType:String;
		
		private var _result:Vector.<Card>;
		
		public function ChoiceParameters(player:Player, numCards:int, fromDeck:String, cardType:String){
			_player = player;
			_numCards = numCards;
			_fromDeck = fromDeck;
			_cardType = cardType;
		}
		
		public function get player():Player{
			return _player;
		}
		
		public function get numCards():int{
			return _numCards;
		}
		
		public function get fromDeck():String{
			return _fromDeck;
		}
		
		public function get cardType():String{
			return _cardType;
		}
		
		public function get result():Vector.<Card>{
			return _result;
		}
		public function set result(value:Vector.<Card>):void{
			_result = value;
		}
	}
}