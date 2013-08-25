package reiter.entities 
{
	import org.flixel.FlxSprite;
	import reiter.assets.Assets;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Zombie extends FlxSprite 
	{
		public var damage:int = 5;
		
		public function Zombie(x:int, y:int) 
		{
			super(x, y);
			loadGraphic(Assets.Zombie);
			//makeGraphic(12, 12, 0xFFFF0000);
			health = 30;
		}
	}
}