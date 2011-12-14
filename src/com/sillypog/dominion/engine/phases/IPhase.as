package com.sillypog.dominion.engine.phases
{
	/**
	 * Turns consist of various phases, eg play actions, buy, cleanup.
	 * This allows those to be encapsulated.
	 */
	public interface IPhase
	{
		function get name():String;
		function get playable():Boolean;
		function get nextPhase():IPhase;
		function play():void;
		function end():void;
	}
}