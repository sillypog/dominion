package com.sillypog.dominion.engine.commands
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.vo.PlayerTurnProperties;

	public class C_ChangePlayerProperty implements ICommand
	{
		private var _player:Player;
		private var _key:String;
		private var _amount:int;
		
		public function C_ChangePlayerProperty(player:Player, propertyKey:String, amount:int)
		{
			_player = player;
			_key = propertyKey;
			_amount = amount;
		}
		
		public function execute():void
		{
			var turnProperties:PlayerTurnProperties = _player.turnProperties;
			
			var newValue:int = turnProperties.change(_key, _amount);
			
			trace(_player.name,_key,'changed by',_amount,'to',newValue);
		}
	}
}