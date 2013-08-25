package reiter.states 
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class GameOverState extends FlxState 
	{
		public function GameOverState() 
		{
			var text:FlxText = new FlxText(100, 100, 100, "Game Over");
			add(text);
		}	
	}

}