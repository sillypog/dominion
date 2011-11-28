package
{
	import com.sillypog.dominion.components.ApplicationButton;
	import com.sillypog.dominion.engine.CardLoader;
	import com.sillypog.dominion.engine.Game;
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.vo.GameBundle;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[SWF(width="800", height="600")]
	public class EngineTester extends MovieClip
	{
		private var buttons:Vector.<ApplicationButton>;
		
		private var cardLoader:CardLoader;
		private var game:Game;
		
		public function EngineTester()
		{
			buttons = new Vector.<ApplicationButton>();
			
			buttons.push(new ApplicationButton('New Game'));
			
			game = Game.instance;
			cardLoader = CardLoader.instance;
			
			cardLoader.addEventListener(cardLoader.CARDS_LOADED, cardsLoaded);
			var sources:Vector.<String> = Vector.<String>(['xml/Universal.xml','xml/Base.xml']);
			cardLoader.load(sources);
			
		}
		
		private function cardsLoaded(e:Event):void{
			trace('Cards Loaded');
			layout();
		}
		
		private function layout():void{
			var bY:Number = 10;
			
			for (var i:int = 0; i < buttons.length; i++){
				buttons[i].x = 10;
				buttons[i].y = bY;
				addChild(buttons[i]);
				bY += buttons[i].height;
				
				buttons[i].addEventListener(MouseEvent.CLICK, buttonClick);
			}
		}
		
		private function buttonClick(e:MouseEvent):void{
			switch(e.currentTarget){
				case buttons[0]: startGame();
					break;
			}
		}
		
		private function startGame():void{
			var players:Vector.<Player> = new Vector.<Player>(2,true);
			players[0] = new Player();
			players[1] = new Player();
			var gameBundle:GameBundle = new GameBundle(players, cardLoader.getUniversal(), cardLoader.getSet());
			game.newGame(gameBundle);
		}
		
	}
}