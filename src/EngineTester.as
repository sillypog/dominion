package
{
	import com.sillypog.dominion.components.ApplicationButton;
	import com.sillypog.dominion.components.ChoiceBox;
	import com.sillypog.dominion.engine.CardLoader;
	import com.sillypog.dominion.engine.Game;
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.events.ChoiceEvent;
	import com.sillypog.dominion.engine.events.GameEvent;
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
		
		private var choiceBox:ChoiceBox;
		
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
			game.addEventListener(ChoiceEvent.CHOICE_REQUIRED, choiceRequired);
			
			choiceBox = new ChoiceBox();
			choiceBox.x = 400;
			choiceBox.visible = false;
		}
		
		private function cardsLoaded(e:Event):void{
			trace('Cards Loaded');
			layout();
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
					bX += lastChild.width + 10;
				}
			}
			
			for (var i:int = numChildren; i < buttons.length; i++){
				buttons[i].x = bX;
				buttons[i].y = bY;
				addChild(buttons[i]);
				bY += buttons[i].height;
				
				if (bY > stage.stageHeight - buttons[i].height){
					bY = 10;
					bX += buttons[i].width + 10;
				}
				
				buttons[i].addEventListener(MouseEvent.CLICK, buttonClick);
			}
			
			addChild(choiceBox);
		}
		
		private function buttonClick(e:MouseEvent):void{
			switch(e.currentTarget){
				case buttons[0]: startGame();
					break;
			}
		}
		
		private function startGame():void{
			var players:Vector.<Player> = new Vector.<Player>(2,true);
			players[0] = new Player(game);
			players[0].name = 'Player A';
			players[1] = new Player(game);
			players[1].name = 'Player B';
			var gameBundle:GameBundle = new GameBundle(players, cardLoader.getUniversal(), cardLoader.getSet());
			
			layoutTable(gameBundle);
			
			game.newGame(gameBundle);
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
		private function layoutTable(bundle:GameBundle):void{
			var universalCards:Vector.<Card> = bundle.universalCards;
			var ucLength:int = universalCards.length;
			for (var i:int = 0; i < ucLength; i++) {
				var buttonName:String = universalCards[i].name;
				buttons.push(new ApplicationButton(buttonName));
			}
			layout();
			
			
			var kcLength:int = bundle.kingdomCards.length;
			for (var j:int = 0; j < kcLength; j++) {
				buttonName = bundle.kingdomCards[j].name;
				buttons.push(new ApplicationButton(buttonName));
			}
			
			layout();
		}
		
		
		private function gameReady(e:Event):void{
			// Get and show counts for all piles
			trace('Game Ready');
			
			// Start the first player
			game.beginTurn();
		}
		
		private function choiceRequired(e:ChoiceEvent):void{
			choiceBox.show(e.params);
		}
		
	}
}