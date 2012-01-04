package com.sillypog.dominion.components
{
	import com.sillypog.dominion.engine.Game;
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.Pile;
	import com.sillypog.dominion.engine.piles.player.PileNames;
	import com.sillypog.dominion.engine.vo.ChoiceParameters;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ChoiceBox extends MovieClip
	{
		private var game:Game;
		
		private var buttons:Vector.<ApplicationButton>;
		
		private var parameters:ChoiceParameters;
		private var cards:Vector.<Card>;
		
		public function ChoiceBox(game:Game)
		{
			super();
			
			this.game = game;
			
			graphics.beginFill(0x999999);
			graphics.drawRect(0,0,300,600);
			
			buttons = new Vector.<ApplicationButton>();
		}
		
		public function show(p:ChoiceParameters):void{
			parameters = p;
		 
			trace(p.player.name,': Choose a',p.cardType,'card to play.');
			
			clear();
			
			visible = true;
			
			// Show buttons for cards in player hand
			var fromPile:Pile = p.player.getPileByName(p.sourcePile);
			cards = fromPile.showVisibleCards(p.player);
			trace('Visible cards in hand',cards);
			
			for (var i:int = 0; i < cards.length; i++){
				var button:ApplicationButton = new ApplicationButton(cards[i].name);
				button.x = 5;
				button.y = 10 + (i * 70);
				addChild(button);
				
				button.addEventListener(MouseEvent.CLICK, selectCard, false, 0, true);
				buttons.push(button);
			}
			
			var doneButton:ApplicationButton = new ApplicationButton('End Phase');
			doneButton.x = 30;
			doneButton.y = height - doneButton.height - 20;
			addChild(doneButton);
			
			doneButton.addEventListener(MouseEvent.CLICK, done, false, 0, true);
			buttons.push(doneButton);
		}
		
		private function clear():void{
			for (var i:int = 0, c:int = buttons.length; i < c; i++){
				buttons[i].removeEventListener(MouseEvent.CLICK, selectCard);
				removeChild(buttons[i]);
			}
			buttons = new Vector.<ApplicationButton>();
		}
		
		/**
		 * Calls into game and triggers a command to move selected cards to appropriate deck.
		 * Send both the parameters and the selection - is it better to send the selection as indices or card references?
		 * Index sholdn't matter - it's not important which of 2 coppers was played
		 */
		private function selectCard(e:MouseEvent):void{
			for (var i:int = 0; i < buttons.length; i++){
				if (e.currentTarget == buttons[i]){
					parameters.result = cards[i];
					break;
				}
			}
			
			var success:Boolean = game.choiceComplete(parameters);
			if (success){
				ApplicationButton(e.currentTarget).visible = false;
				game.continueTurn();
			}
		}
		
		/**
		 * End phase without further selection.
		 */
		private function done(e:MouseEvent):void{
			parameters.result = null;
			game.choiceComplete(parameters);
		}
		
		
	}
}