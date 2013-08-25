package reiter.states 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class NodeContainer 
	{
		public var nodeList:Vector.<Node> = new Vector.<Node>();
		
		public function NodeContainer() 
		{
			
		}
		
		public function add(node:Node) : void
		{
			nodeList.push(node);
		}
		
		public function getNode(root:FlxPoint) : Node
		{
			for each(var node:Node in nodeList)
			{
				if (node.root.x == root.x && node.root.y == root.y)
				{
					return node;
				}
			}
			
			return null;
		}
	}

}