package
{
	import com.sillypog.dominion.components.ApplicationButton;
	import com.sillypog.dominion.components.CardButton;
	import com.sillypog.dominion.components.ChoiceBox;
	import com.sillypog.dominion.engine.CardLoader;
	import com.sillypog.dominion.engine.Game;
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.Table;
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.events.BuyEvent;
	import com.sillypog.dominion.engine.events.ChoiceEvent;
	import com.sillypog.dominion.engine.events.GameEvent;
	import com.sillypog.dominion.engine.piles.Pile;
	import com.sillypog.dominion.engine.vo.BuyParameters;
	import com.sillypog.dominion.engine.vo.ChoiceParameters;
	import com.sillypog.dominion.engine.vo.GameBundle;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width="800", height="600")]
	public class EngineTester extends MovieClip
	{
		private var buttons:Vector.<ApplicationButton>;
		
		private var cardLoader:CardLoader;
		private var game:Game;
		private var players:Vector.<Player>
		
		private var choiceBox:ChoiceBox;
		
		private var currentBuy:BuyParameters;
		
		public function EngineTester()
		{
			buttons = new Vector.<ApplicationButton>();
			
			buttons.push(new ApplicationButton('Start'));
			
			game = Game.instance;
			cardLoader = CardLoader.instance;
			
			cardLoader.addEventListener(cardLoader.CARDS_LOADED, cardsLoaded);
			var sources:Vector.<String> = Vector.<String>(['xml/Universal.xml','xml/Base.xml']);
			cardLoader.load(sources);
			
			game.addEventListener(GameEvent.GAME_READY, gameReady);
			game.addEventListener(ChoiceEvent.CHOOSE_FROM_PILE, choiceRequired);
			game.addEventListener(BuyEvent.CHOOSE_BUY, chooseBuy);
			game.addEventListener(GameEvent.TURN_COMPLETE, turnComplete);
			game.addEventListener(GameEvent.GAME_OVER, gameOver);
			
			choiceBox = new ChoiceBox(game);
			choiceBox.x = 400;
			choiceBox.visible = false;
		}
		
		private function cardsLoaded(e:Event):void{
			trace('Cards Loaded');
			layout();
		}
		
		private function startGame():void{
			
			buttons.push(new ApplicationButton('Next Turn'));
			buttons[1].enabled = false;
			layout();
			
			players = new Vector.<Player>(2,true);
			players[0] = new Player(game);
			players[0].name = 'Player A';
			players[1] = new Player(game);
			players[1].name = 'Player B';
			var gameBundle:GameBundle = new GameBundle(players, cardLoader.getUniversal(), cardLoader.getSet());
			
			game.newGame(gameBundle);
		}
		
		private function gameReady(e:Event):void{
			trace('Game Ready');
			
			// Get and show counts for all piles
			layoutTable();
			
			// Start the first player
			game.beginTurn();
		}
		
		
		/**
		 * Set up the table.
		 * How should the display of the piles be handled? Should I get references to the actual piles?
		 * When a pile changes, the display will need to be changed to what the pile currently is, so keeping references to piles is probably
		 * a good idea.
		 * 
		 * Alternatively, I know the players and cards because they were passed in from here via Game bundle. 
		 * So I should be able to create the slots for the piles from that, then poll the game to get the counts for those piles.
		 */
		private function layoutTable():void{
			var table:Table = Table.instance;
			
			layoutSupply(table.supply.universalPiles());
			layoutSupply(table.supply.kingdomPiles());
		}
		
		private function layoutSupply(piles:Vector.<Pile>):void{
			var pileCount:int = piles.length;
			for (var i:int = 0; i < pileCount; i++) {
				buttons.push(new CardButton(piles[i]));
			}
			layout();
		}
		
		private function choiceRequired(e:ChoiceEvent):void{
			choiceBox.show(e.params);
		}
		
		private function chooseBuy(e:BuyEvent):void{
			currentBuy = e.parameters;
		}
		
		private function buyCard(button:ApplicationButton):void{
			if (!currentBuy){
				trace('No buy yet')
				return;
			}
			var pile:Pile = Table.instance.getPileByName(button.label);
			currentBuy.purchase = pile;
			
			var success:Boolean = game.buyComplete(currentBuy);
			
			if (success){
				currentBuy = null;	// This is preventing legitimate second buys.
				game.continueTurn();
			} else {
				trace('Buy failed');
			}
		}
		
		private function turnComplete(e:Event):void{
			trace('\nIt is',Player(game.getPlayer('Next')).name,"'s turn.\n");
			buttons[1].enabled = true;
			layout();
		}
		
		private function nextTurn():void{
			trace('New turn start');
			buttons[1].enabled = false;
			game.nextPlayer();
			game.beginTurn();
		}
		
		private function gameOver(e:Event):void{
			trace('Game Over.');
			for (var i:int = 0; i < players.length; i++){
				trace(players[i].name, players[i].victoryPoints);
			}
		}
		
		private function layout():void{
			if (choiceBox.parent){
				removeChild(choiceBox);
			}
			
			var bY:Number = 10;
			var bX:Number = 10;
			if (numChildren > 0){
				var lastChild:DisplayObject = getChildAt(numChildren-1);
				bY = lastChild.y + lastChild.height + 20;
				bX = lastChild.x;
				
				if (bY > stage.stageHeight - lastChild.height){
					bY = 10;
					bX += 150;
				}
			}
			
			for (var i:int = numChildren; i < buttons.length; i++){
				buttons[i].x = bX;
				buttons[i].y = bY;
				addChild(buttons[i]);
				bY += buttons[i].height;
				
				if (bY > stage.stageHeight - buttons[i].height){
					bY = 10;
					bX += 150;
				}
				
				if (!buttons[i].hasEventListener(MouseEvent.CLICK)){
					buttons[i].addEventListener(MouseEvent.CLICK, buttonClick);
				}
			}
			
			addChild(choiceBox);
		}
		
		private function buttonClick(e:MouseEvent):void{
			var button:ApplicationButton = ApplicationButton(e.currentTarget);
			switch(button.label){
				case 'Start': startGame();
					break;
				case 'Next Turn': nextTurn();
					break;
				default: buyCard(ApplicationButton(e.currentTarget));
			}
		}
	}
}