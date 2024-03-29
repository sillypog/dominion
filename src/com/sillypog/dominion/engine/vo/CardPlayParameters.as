package com.sillypog.dominion.engine.vo
{
	public class CardPlayParameters
	{
		private var _affects:String;
		private var _type:String;
		private var _property:String;
		private var _amount:int;
		
		public function CardPlayParameters(affects:String, type:String, property:String, amount:int)
		{
			_affects = affects;
			_type = type;
			_property = property;
			_amount = amount;
		}
		
		public function get affects():String{
			return _affects;
		}
		
		public function get type():String{
			return _type;
		}
		
		public function get property():String{
			return _property;
		}
		
		public function get amount():int{
			return _amount;
		}
	}
}