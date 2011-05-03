package com.sillypog.dominion.view
{
	import com.sillypog.dominion.components.ApplicationButton;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class HomeScreen extends Sprite
	{
		private var newButton:ApplicationButton;
		
		public function HomeScreen()
		{
			addEventListener(Event.ADDED_TO_STAGE, initLayout);
		}
		
		private function initLayout(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, initLayout);
			
			newButton = new ApplicationButton('New Game');
			addChild(newButton);
			newButton.x = (stage.stageWidth / 2) - (newButton.width / 2);
			newButton.y = (stage.stageHeight / 2) - (newButton.width / 2);
		}
		
	}
}