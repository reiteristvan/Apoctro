package reiter.entities 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Beam extends FlxSprite 
	{		
		public function Beam(x:int, y:int, _width:int, _height:int) 
		{
			super(x, y);
			width = _width;
			height = _height;
			makeGraphic(width, height, 0xFF00FFFF);
		}
		
		override public function revive():void 
		{
			makeGraphic(width, height, 0xFF00FFFF);
			super.revive();
		}
	}

}