package com.sillypog.dominion.engine.cards
{
	public class Card
	{
		private var _name:String;
		private var _type:Vector.<String>;
		private var _cost:Cost;
				
		public function Card(description:XML){
			
			_name = description.@name;
			
			_type = new Vector.<String>(description.type.length());
			for each(var typeXML:XML in description.type){
				_type.push(typeXML.toString());
			}
			
			_cost = new Cost(description.cost[0]);
		}
		
		public function get name():String{
			return _name;
		}
		
		public function isType(type:String):Boolean{
			var index:int = _type.indexOf(type);
			return index > -1;
		}
		
		public function toString():String{
			return _name;
		}
		
		public function play():void{
			trace(_name,'played');
		}
		
		
	}
}