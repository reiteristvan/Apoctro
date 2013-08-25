package reiter.apoctro
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	import reiter.states.Environment;
	import reiter.states.PlayState;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Main extends FlxGame
	{		
		public function Main() : void 
		{	
			super(640, 480, PlayState);
			FlxG.mouse.show();
		}	
	}
	
}