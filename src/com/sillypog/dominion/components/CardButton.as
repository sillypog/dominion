package com.sillypog.dominion.components
{
	import flash.text.TextField;

	public class CardButton extends ApplicationButton
	{
		private var _countLabel:TextField;
		
		public function CardButton(label:String)
		{
			super(label);
			
			_countLabel = new TextField();
			_countLabel.text = '10';
			_countLabel.textColor = 0xFF0000;
			_countLabel.height = 20;

			addChild(_countLabel);
		}
		
		public function get count():int{
			return int(_countLabel.text);
		}
		public function set count(value:int):void{
			_countLabel.text = String(value);
		}
	}
}