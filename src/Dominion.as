package {
	
	import com.sillypog.dominion.view.HomeScreen;
	
	import flash.display.Sprite;

	[SWF(width="480", height="800")]
	public class Dominion extends Sprite
	{
		public function Dominion()
		{
			initialiseApplication();
		}
		
		private function initialiseApplication():void{
			addChild(new HomeScreen());
		}
	}
}
