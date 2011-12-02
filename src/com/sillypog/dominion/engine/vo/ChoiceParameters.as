package com.sillypog.dominion.engine.vo
{
	public class ChoiceParameters
	{
		private var _numCards:int;
		private var _cardType:String;
		
		public function ChoiceParameters(numCards:int, cardType:String){
			_numCards = numCards;
			_cardType = cardType;
		}
		
		public function get numCards():int{
			return _numCards;
		}
		
		public function get cardType():String{
			return _cardType;
		}
	}
}