package reiter.assets 
{
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Assets 
	{
		[Embed(source="zombie.png")]
		static public const Zombie:Class;
		
		[Embed(source="tower.png")]
		static public const Tower:Class;
		
		[Embed(source="towerOff.png")]
		static public const TowerOff:Class;
		
		public function Assets() 
		{
			
		}		
	}

}