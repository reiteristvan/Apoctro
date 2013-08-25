package reiter.entities 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class SubBase extends FlxSprite 
	{	
		public function SubBase(x:int, y:int) : void
		{
			super(x, y);
			makeGraphic(12, 12, 0xFFFF5500);
		}
	}

}