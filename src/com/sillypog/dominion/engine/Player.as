package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.events.CardPlayEvent;
	import com.sillypog.dominion.engine.piles.IPileOwner;
	import com.sillypog.dominion.engine.piles.Pile;
	import com.sillypog.dominion.engine.piles.player.Deck;
	import com.sillypog.dominion.engine.piles.player.Discard;
	import com.sillypog.dominion.engine.piles.player.Hand;
	import com.sillypog.dominion.engine.piles.player.PileNames;
	import com.sillypog.dominion.engine.piles.player.PlayArea;
	import com.sillypog.dominion.engine.piles.player.PlayerPile;
	import com.sillypog.dominion.engine.piles.player.Reveal;
	import com.sillypog.dominion.engine.vo.BuyParameters;
	import com.sillypog.dominion.engine.vo.CardPlayParameters;
	import com.sillypog.dominion.engine.vo.ChoiceParameters;
	import com.sillypog.dominion.engine.vo.PlayerTurnProperties;
	
	import flash.utils.Dictionary;
	
	/**
	 * Application creates these objects and passes them into the game.
	 * Override the class to create AI players by listening for game events, etc.
	 */
	public class Player implements IPileOwner
	{
		private var _name:String;
		
		private var game:Game;
		private var piles:Dictionary;
		
		private var _turnProperties:PlayerTurnProperties;
		
		public function Player(game:Game){
			
			this.game = game;
			
			piles = new Dictionary();
			createPile(new Deck(this));
			createPile(new Hand(this));
			createPile(new PlayArea(this));
			createPile(new Reveal(this));
			createPile(new Discard(this));
			// set aside
			// duration
			
			getPileByName(PileNames.PLAY_AREA).addEventListener(CardPlayEvent.CARD_PLAYED, game.cardPlayed);
			
			_turnProperties = new PlayerTurnProperties();
		}
		
		public function get name():String{
			return _name;
		}
		public function set name(value:String):void{
			_name = value;
		}
		
		public function get turnProperties():PlayerTurnProperties{
			return _turnProperties;
		}
		
		public function getPileByName(pileName:String):Pile{
			return piles[pileName];
		}
		
		/**
		 * This is the type of choice where a card must be chosen from several, eg which card from hand to play
		 */
		public function chooseCard(requirements:ChoiceParameters):void{
			game.choiceRequired(requirements);
			// In AI players, this would be handled internally
		}
		
		public function chooseBuy(treasure:int):void{
			var buyParameters:BuyParameters = new BuyParameters(this, treasure, getPileByName(PileNames.PLAY_AREA));
			game.chooseBuy(buyParameters)
		}
		
		
		
		private function createPile(pile:PlayerPile):void{
			piles[pile.name] = pile;
		}
		
	}
}