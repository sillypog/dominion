package com.sillypog.dominion.engine.commands
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.piles.player.PlayerPile;

	/**
	 * Used extensively in CleanupPhase to move everything to discard.
	 * Chancellor should also use this if the player chooses to put their draw pile in discard.
	 */
	public class C_TransferPlayerPile implements ICommand
	{
		private var _player:Player;
		private var _source:String;
		private var _destination:String;
		
		private var sourcePile:PlayerPile;
		private var destinationPile:PlayerPile;
		
		public function C_TransferPlayerPile(player:Player, source:String, destination:String)
		{
			_player = player;
			this.source = source;
			_destination = destination;
			
			destinationPile = PlayerPile(player.getPileByName(destination));
		}
		
		/**
		 * To make this more efficient in CleanupPhase, source can be changed without specifying other parameters again.
		 */
		public function get source():String{
			return _source;
		}
		public function set source(value:String):void{
			_source = value;
			sourcePile = PlayerPile(_player.getPileByName(value));
		}
		
		public function execute():void
		{
			destinationPile.addCards(sourcePile.removeAllCards());
		}
	}
}