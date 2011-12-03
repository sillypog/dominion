package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.Pile;
	import com.sillypog.dominion.engine.piles.player.Deck;
	import com.sillypog.dominion.engine.piles.player.Discard;
	import com.sillypog.dominion.engine.piles.player.Hand;
	import com.sillypog.dominion.engine.piles.player.PlayArea;
	import com.sillypog.dominion.engine.piles.player.PlayerPile;
	import com.sillypog.dominion.engine.piles.player.Reveal;
	import com.sillypog.dominion.engine.vo.ChoiceParameters;
	
	import flash.utils.Dictionary;
	
	
	public class Player
	{
		private var _name:String;
		
		private var game:Game;
		private var piles:Dictionary;
		
		public function Player(game:Game){
			
			this.game = game;
			
			piles = new Dictionary();
			createPile(new Deck());
			createPile(new Hand());
			createPile(new PlayArea());
			createPile(new Reveal());
			createPile(new Discard());
			// set aside
			// duration
		}
		
		public function get name():String{
			return _name;
		}
		public function set name(value:String):void{
			_name = value;
		}
		
		public function getPileByName(pileName:String):Pile{
			return piles[pileName];
		}
		
		public function choiceRequired(requirements:ChoiceParameters):void{
			//game.choiceRequired(requirements);
			trace('Choice required');
		}
		
		private function createPile(pile:PlayerPile):void{
			piles[pile.name] = pile;
		}
		
	}
}