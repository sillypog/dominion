package com.sillypog.dominion.engine
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.cards.KingdomCard;
	import com.sillypog.dominion.engine.piles.MixedPile;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	/**
	 * Loads all the available Kingdom cards prior to game creation.
	 * 
	 * Singleton class.
	 */
	public class CardLoader extends EventDispatcher{
		
		private static var _instance:CardLoader;
		
		public const CARDS_LOADED:String = 'Cards Loaded';
		
		private var _loader:URLLoader;
		private var _sources:Vector.<String>;
		
		private var _universalCards:Vector.<Card>;
		private var _kingdomCards:Vector.<KingdomCard>;
		private var _cardLookup:Dictionary;
		
		public static function get instance():CardLoader{
			if (!_instance){
				_instance = new CardLoader(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function CardLoader(enforcer:SingletonEnforcer){
			_universalCards = new Vector.<Card>();
			_kingdomCards = new Vector.<KingdomCard>();
			_cardLookup = new Dictionary();
			
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, cardsLoaded);
		}
		
		/**
		 * Loads the xml files that describe the game cards.
		 */
		public function load(sources:Vector.<String>):void{
			_sources = sources;
			var source:String = sources.shift();
			_loader.load(new URLRequest(source));
		}
		
		/**
		 * Provides the universal cards to be placed in the supply.
		 * 
		 * @param criteria Determines whether or not optional cards, eg Platinum are included.
		 * @return The universal cards to be placed in the supply.
		 */
		public function getUniversal(criteria:Object = null):Vector.<Card>{
			return _universalCards;
		}
		
		/**
		 * Selects 10 of the available kingdom cards based on any restrictions.
		 * 
		 * @param criteria Description of cards to include/exlude from set.
		 * @return The 10 kingdom cards to be used in the upcoming game.
		 */
		public function getSet(criteria:Object = null):Vector.<KingdomCard>{
			return _kingdomCards.slice(0, 10);
		}
		
		private function cardsLoaded(e:Event):void{
			parseXML(XML(_loader.data));
			
			if (_sources.length){
				load(_sources);
			} else {
				var loadedEvent:Event = new Event(CARDS_LOADED);
				dispatchEvent(loadedEvent);
			}
		}
		
		private function parseXML(xml:XML):void{
			var universalType:Boolean = xml.@type == 'Universal';
			var card:Card;
			for each(var cardXML:XML in xml.card){
				if (universalType){
					card = new Card(cardXML);
					_universalCards.push(card);
				} else {
					card = new KingdomCard(cardXML);
					_kingdomCards.push(card);
				}
				_cardLookup[card.name] = card;
			}
			MixedPile.setCardLookup(_cardLookup);
		}
	}
}

class SingletonEnforcer{}