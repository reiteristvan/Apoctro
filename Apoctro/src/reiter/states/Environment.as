package reiter.states 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class Environment 
	{
		static public var spawnPoints:Array = new Array(
			new FlxPoint(174, 10), new FlxPoint(314, 10), new FlxPoint(454, 10), 
			new FlxPoint(174, 458), new FlxPoint(314, 458), new FlxPoint(454, 458), 
			new FlxPoint(10, 147), new FlxPoint(10, 238), new FlxPoint(10, 328), 
			new FlxPoint(618, 147), new FlxPoint(618, 238), new FlxPoint(618, 328)
			);
		
			
		static public var nodePoints:Array = new Array(
			new FlxPoint(174, 10), // 0
			new FlxPoint(314, 10), // 1
			new FlxPoint(454, 10), // 2 top row
			new FlxPoint(10, 147), // 3
			new FlxPoint(174, 147), // 4
			new FlxPoint(320, 147), // 5
			new FlxPoint(454, 147), // 6
			new FlxPoint(618, 147), // 7 second row
			new FlxPoint(10, 238), // 8
			new FlxPoint(174, 238), // 9
			new FlxPoint(320, 238), // 10
			new FlxPoint(454, 238), // 11
			new FlxPoint(618, 238), // 12 third row
			new FlxPoint(10, 328), // 13
			new FlxPoint(174, 328), // 14
			new FlxPoint(320, 328), // 15
			new FlxPoint(454, 328), // 16
			new FlxPoint(618, 328), // 17 fourth row
			new FlxPoint(174, 458), // 18
			new FlxPoint(314, 458), // 19
			new FlxPoint(454, 458) // 20 bottom row
		);
		
		static public var nodeContainer:NodeContainer = new NodeContainer();
		
		static public function Init() : void
		{
			var list:Array = new Array();
			list.push(new Node(2, nodePoints[0], new Array(nodePoints[1], nodePoints[4])));
			list.push(new Node(3, nodePoints[1], new Array(nodePoints[2], nodePoints[5], nodePoints[0])));
			list.push(new Node(2, nodePoints[2], new Array(nodePoints[1], nodePoints[6])));
			list.push(new Node(2, nodePoints[3], new Array(nodePoints[4], nodePoints[8])));
			list.push(new Node(4, nodePoints[4], new Array(nodePoints[0], nodePoints[3], nodePoints[9], nodePoints[5])));
			list.push(new Node(4, nodePoints[5], new Array(nodePoints[1], nodePoints[4], nodePoints[10], nodePoints[6])));
			list.push(new Node(4, nodePoints[6], new Array(nodePoints[2], nodePoints[5], nodePoints[11], nodePoints[7])));
			list.push(new Node(2, nodePoints[7], new Array(nodePoints[6], nodePoints[12])));
			list.push(new Node(3, nodePoints[8], new Array(nodePoints[3], nodePoints[9], nodePoints[13])));
			list.push(new Node(4, nodePoints[9], new Array(nodePoints[4], nodePoints[8], nodePoints[10], nodePoints[14])));
			list.push(new Node(4, nodePoints[10], new Array(nodePoints[5], nodePoints[9], nodePoints[11], nodePoints[15])));
			list.push(new Node(4, nodePoints[11], new Array(nodePoints[6], nodePoints[10], nodePoints[16], nodePoints[12])));
			list.push(new Node(3, nodePoints[12], new Array(nodePoints[11], nodePoints[7], nodePoints[17])));
			list.push(new Node(2, nodePoints[13], new Array(nodePoints[8], nodePoints[14])));
			list.push(new Node(4, nodePoints[14], new Array(nodePoints[9], nodePoints[13], nodePoints[15], nodePoints[18])));
			list.push(new Node(4, nodePoints[15], new Array(nodePoints[10], nodePoints[14], nodePoints[16], nodePoints[19])));
			list.push(new Node(4, nodePoints[16], new Array(nodePoints[11], nodePoints[15], nodePoints[17], nodePoints[20])));
			list.push(new Node(2, nodePoints[17], new Array(nodePoints[16], nodePoints[12])));
			list.push(new Node(2, nodePoints[18], new Array(nodePoints[14], nodePoints[19])));
			list.push(new Node(3, nodePoints[19], new Array(nodePoints[18], nodePoints[15], nodePoints[20])));
			list.push(new Node(2, nodePoints[20], new Array(nodePoints[16], nodePoints[19])));
			
			for each(var item:Node in list)
			{
				nodeContainer.add(item);
			}
		}
		
		public function Environment() 
		{
			
		}
	}

}