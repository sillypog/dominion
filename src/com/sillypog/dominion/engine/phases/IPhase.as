package com.sillypog.dominion.engine.phases
{
	import com.sillypog.dominion.engine.Player;
	import com.sillypog.dominion.engine.Turn;

	/**
	 * Turns consist of various phases, eg play actions, buy, cleanup.
	 * This allows those to be encapsulated.
	 */
	public interface IPhase
	{
		function get name():String;
		function get nextPhase():IPhase;
		function play(turn:Turn, player:Player):void;
	}
}