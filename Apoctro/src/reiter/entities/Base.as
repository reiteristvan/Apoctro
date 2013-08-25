package reiter.entities 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Base extends FlxSprite 
	{
		public var energy:int = 60;
		
		public function Base(x:int, y:int) : void
		{
			super(x, y);
			health = 100;
			makeGraphic(32, 32, 0xFF00FF55);
		}
		
		public function activate() : void
		{
			
		}
		
		public function deactivate() : void
		{
			
		}
	}
}