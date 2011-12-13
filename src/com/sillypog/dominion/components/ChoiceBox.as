package com.sillypog.dominion.components
{
	import com.sillypog.dominion.engine.cards.Card;
	import com.sillypog.dominion.engine.piles.Pile;
	import com.sillypog.dominion.engine.piles.player.PileNames;
	import com.sillypog.dominion.engine.vo.ChoiceParameters;
	
	import flash.display.MovieClip;
	
	public class ChoiceBox extends MovieClip
	{
		private var buttons:Vector.<ApplicationButton>;
		
		public function ChoiceBox()
		{
			super();
			graphics.beginFill(0x999999);
			graphics.drawRect(0,0,300,600);
			
			buttons = new Vector.<ApplicationButton>();
		}
		
		public function show(p:ChoiceParameters):void{
			trace(p.player.name,': Choose',p.numCards,p.cardType,'card to play.');
			
			visible = true;
			
			// Show buttons for cards in player hand
			var hand:Pile = p.player.getPileByName(PileNames.HAND);
			var cards:Vector.<Card> = hand.showVisibleCards(p.player);
			trace('Visible cards in hand',cards);
			
			for (var i:int = 0; i < cards.length; i++){
				var button:ApplicationButton = new ApplicationButton(cards[i].name);
				button.x = 5;
				button.y = 10 + (i * 70);
				addChild(button);
			}
		}
	}
}