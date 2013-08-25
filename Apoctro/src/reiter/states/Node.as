package reiter.states 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Node 
	{
		public var length:int = 0;
		public var root:FlxPoint;
		public var nodes:Array;
		
		public function Node(_length:int, _root:FlxPoint, _nodes:Array) : void 
		{
			length = _length;
			root = _root;
			nodes = _nodes;
		}
	}
}