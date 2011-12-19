package com.sillypog.dominion.engine.cards
{
	import com.sillypog.dominion.engine.events.CardPlayEvent;
	import com.sillypog.dominion.engine.vo.CardPlayParameters;
	
	import flash.events.EventDispatcher;

	public class Card extends EventDispatcher
	{
		private var _name:String;
		private var _type:Vector.<String>;
		private var _cost:Cost;
		
		private var playSteps:Vector.<CardPlayParameters>;
				
		public function Card(description:XML){
			
			_name = description.@name;
			
			_type = new Vector.<String>(description.type.length());
			for each(var typeXML:XML in description.type){
				_type.push(typeXML.toString());
			}
			
			_cost = new Cost(description.cost[0]);
			
			parsePlay(description.play[0]);
		}
		
		public function get name():String{
			return _name;
		}
		
		public function isType(type:String):Boolean{
			var index:int = _type.indexOf(type);
			return index > -1;
		}
		
		public function play():void{
			trace(_name,'played');
			// Send the steps to Game so they can be run through the appropriate command
			var playEvent:CardPlayEvent = new CardPlayEvent(this, playSteps);
			dispatchEvent(playEvent);
		}
		
		override public function toString():String{
			return _name;
		}
		
		private function parsePlay(description:XML):void{
			if (!description){
				return;	// This is because not all cards have play nodes yet
			}
			var steps:XMLList = description..step;
			playSteps = new Vector.<CardPlayParameters>(steps.length(), true);
			
			for (var i:int = 0, c:int = playSteps.length; i < c; i++){
				var stepDescription:XML = steps[i];
				var step:CardPlayParameters = new CardPlayParameters(stepDescription.affects,
																	 stepDescription.effect.property, 
																	 stepDescription.effect.amount);
				playSteps[i] = step;
			}
		}
		
		
	}
}