package com.sillypog.dominion.engine.piles
{	
	/**
	 * Piles have different visibility depending on whether the pile belongs to the player doing the looking.
	 * By giving piles owners, the looking request can check who it is owned by and return the correct visible cards.
	 */
	public interface IPileOwner
	{
		function getPileByName(pileName:String):Pile;
	
	}
}