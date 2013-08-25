package reiter.entities 
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import reiter.assets.Assets;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Tower extends FlxSprite 
	{
		public var onClick:Function = null;
		public var damage:int = 10;
		public var on:Boolean = false;
		public var coordinate:FlxPoint = new FlxPoint();
		
		public function Tower(x:int, y:int) 
		{
			super(x, y);
			health = 50;
			//makeGraphic(16, 16, 0xFF00FF00);
			loadGraphic(Assets.Tower);
			status(false);
		}
		
		public function status(s:Boolean) : void
		{
			on = s;
			loadGraphic(on == true ? Assets.Tower : Assets.TowerOff);
		}
		
		override public function update():void 
		{
			if (FlxG.mouse.justReleased() && isMouseOver())
			{
				//status(!on);
				if (onClick != null)
				{
					onClick(this);
				}
			}
			
			super.update();
		}
		
		private function isMouseOver() : Boolean
		{
			var p:FlxPoint = FlxG.mouse.getScreenPosition();
			
			if ((p.x >= x && p.x <= x + width) && (p.y >= y && p.y <= y + height))
			{
				return true;
			}
			
			return false;
		}
	}
}