package com.sillypog.dominion.engine.cards
{
	import com.sillypog.dominion.engine.vo.CardPlayParameters;
	import com.sillypog.dominion.engine.vo.Cost;

	public class Card
	{
		private var _name:String;
		private var _type:Vector.<String>;
		private var _cost:Cost;
		
		private var _playSteps:Vector.<CardPlayParameters>;
				
		public function Card(description:XML){
			
			_name = description.@name;
			
			_type = new Vector.<String>(description.type.length());
			for each(var typeXML:XML in description.type){
				_type.push(typeXML.toString());
			}
			
			_cost = new Cost(description.cost[0]);
			
			_playSteps = parseSteps(description.play[0]);
		}
		
		public function get name():String{
			return _name;
		}
		
		public function get cost():Cost{
			return _cost;
		}
		
		public function isType(type:String):Boolean{
			var index:int = _type.indexOf(type);
			return index > -1;
		}
		
		/**
		 * Send the steps to Game so they can be run through the appropriate command.
		 * AI players may use this method to check what a card does before playing it.
		 */
		public function play():Vector.<CardPlayParameters>{
			return _playSteps;
		}
		
		public function toString():String{
			return _name;
		}
		
		/**
		 * Generic function that will be able to parse play and durationPlay steps.
		 */
		private function parseSteps(description:XML):Vector.<CardPlayParameters>{
			if (!description){
				return null;	// This is because not all cards have play nodes yet
			}
			
			var stepList:XMLList = description..step;
			var steps:Vector.<CardPlayParameters> = new Vector.<CardPlayParameters>(stepList.length(), true);
			
			for (var i:int = 0, c:int = steps.length; i < c; i++){
				var stepDescription:XML = stepList[i];
				var step:CardPlayParameters = new CardPlayParameters(stepDescription.affects,
																	 stepDescription.effect.@type,
																	 stepDescription.effect.property, 
																	 stepDescription.effect.amount);
				steps[i] = step;
			}
			
			return steps;
		}
		
		
	}
}