package com.sillypog.dominion.engine.piles
{
	/** 
	 * The Trash Pile
	 */
	public class Trash extends MixedPile
	{
		public function Trash(owner:IPileOwner)
		{
			super(owner);
			
			this.tableVisibility = VISIBILITY_TOP;
		}
	}
}