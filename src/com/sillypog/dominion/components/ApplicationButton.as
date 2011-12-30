package com.sillypog.dominion.components
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.setTimeout;

	public class ApplicationButton extends Sprite
	{
		private var _label:String;
		
		public function ApplicationButton(label:String)
		{
			_label = label;
			
			var labelField:TextField = new TextField();
			labelField.text = label;
			labelField.setTextFormat(new TextFormat(null, 24, null, true, null, null, null, null, TextFormatAlign.CENTER));
			labelField.autoSize = TextFieldAutoSize.LEFT;
			labelField.x = 10;
			labelField.y = 3;
			labelField.selectable = false;
			labelField.mouseEnabled = false;
			addChild(labelField);
			
			graphics.beginFill(0x99CCFF);
			graphics.lineStyle(1,0x3399CC,1,true);
			graphics.drawRoundRect(0,0,labelField.width + 20, labelField.height + 6, 10);
			graphics.endFill();
			
			buttonMode = true;
			
			addEventListener(MouseEvent.MOUSE_DOWN, highlight);
			addEventListener(MouseEvent.MOUSE_UP, lowlight);
		}
		
		public function get label():String{
			return _label;
		}
		
		public function set enabled(value:Boolean):void{
			mouseEnabled = value;
			alpha = value ? 1 : 0.25; 
		}
		
		private function highlight(e:MouseEvent):void{
			this.alpha = 0.5;
		}
		
		private function lowlight(e:MouseEvent):void{
			alpha = 1;
		}
		
	}
}