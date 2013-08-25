package reiter.states 
{
	import adobe.utils.CustomActions;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import reiter.entities.Base;
	import reiter.entities.Beam;
	import reiter.entities.SubBase;
	import reiter.entities.Tower;
	import reiter.entities.Zombie;
	
	/**
	 * ...
	 * @author Istvan Reiter
	 */
	public class PlayState extends FlxState 
	{
		public var pointsText:FlxText = new FlxText(10, 10, 150, "0");
		public var waveText:FlxText = new FlxText(500, 10, 100, "Wave: ");
		public var infoText:FlxText = new FlxText(160, 50, 400, "Prepare for next wave!");
		public var points:int = 0;
		public var zombies:FlxGroup = new FlxGroup();
		public var towers:FlxGroup = new FlxGroup();
		public var beams:FlxGroup = new FlxGroup();
		public var subBases:FlxGroup = new FlxGroup();
		public var base:Base = new Base(304, 224);
		public var energy:int = 100;
		public var maxTower:int = 3;
		public var towerCount:int = 0;
		
		public function PlayState() : void
		{				
			Environment.Init();
			
			pointsText.size = 14;
			waveText.size = 14;
			infoText.size = 20;
			
			add(pointsText);
			add(waveText);
			add(infoText);
			add(base);
			add(subBases);
			add(towers);
			add(beams);
			add(zombies);
			
			initTowers();
			
			infoText.visible = false;
			base.deactivate();
		}	
		
		public function handleTowerClick(tower:Tower) : void
		{
			// turn off tower
			if (tower.on)
			{	
				for each(var beam:Beam in beams.members)
				{
					if (beam.alive &&
						(beam.x == tower.x - beam.width && beam.y == tower.y)
						||
						(beam.x == tower.x + 16 && beam.y == tower.y)
						||
						(beam.x == tower.x) && (beam.y == tower.y - beam.height || beam.y == tower.y + 16)
						)
					{
						beam.kill();
					}
				}
				
				tower.status(false);
				--towerCount;
				return;
			}
			
			if (towerCount == maxTower) { return; }
			
			tower.status(true);
			++towerCount;
			
			// get neighbour towers
			var n:Array = new Array();
			for each(var t:Tower in towers.members)
			{
				if ((t.coordinate.x == tower.coordinate.x && Math.abs(t.coordinate.y - tower.coordinate.y) == 1) 
					|| 
					(t.coordinate.y == tower.coordinate.y && Math.abs(t.coordinate.x - tower.coordinate.x) == 1))
				{
					n.push(t);
				}
			}
			
			// add beam if tower is active
			for each(var tow:Tower in n)
			{
				if (tow.on)
				{
					var _x:int = 0;
					var _y:int = 0;
					var _width:int = 0;
					var _height:int = 0;
					
					if (tow.x < tower.x) 
					{ 
						_x = tow.x + 16; 
						_y = tower.y; 
						_width = tower.x - _x; 
						_height = 16; 
					}
					else if (tow.x > tower.x) 
					{ 
						_x = tower.x + 16; 
						_y = tower.y; 
						_width = tow.x - _x; 
						_height = 16; 
					}
					else 
					{ 
						_x = tower.x; 
						_y = tow.y > tower.y ? tower.y + 16 : tow.y + 16;
						_width = 16;
						_height = _y < tower.y ? tower.y - _y : tow.y - _y;
					}
					
					var b:Beam = beams.getFirstDead() as Beam;
					if (b == null)
					{
						b = new Beam(_x, _y, _width, _height);
						beams.add(b);
					}
					else
					{
						b.x = _x; b.y = _y; b.width = _width; b.height = _height;
						b.revive();
					}
				}
			}
		}
		
		public var _wave:int = 0;
		public var _zombieInWave:int = 0;
		public var _spawnInterval:Number = 0.5;
		public var _coolDownTime:Number = 3.0;
		public var _zombieCounter:int = 0;
		public var _deadZombieCounter:int = 0;
		
		override public function update():void 
		{
			// collision
			
			FlxG.overlap(zombies, beams, zombieVsLaser);
			FlxG.overlap(zombies, subBases, zombieVsSubBase);
			FlxG.overlap(zombies, base, zombieVsBase);
			
			super.update();
			
			// vawe management & zombie spawning
			
			// check if all zombie dead in the vawe
			if (_deadZombieCounter == _zombieInWave)
			{
				infoText.visible = true;
				
				// cooldown
				_coolDownTime -= FlxG.elapsed;
				if (_coolDownTime > 0)
				{
					// nothing to do
					return;
				}
				
				infoText.visible = false;
				_coolDownTime = 3.0;
				
				// start new wave
				++_wave;

				waveText.text = "Wave: " + _wave.toString();
				
				// set vawe data
				_deadZombieCounter = 0;
				_zombieCounter = 0;
				_zombieInWave = 3 * _wave + 2;
				_spawnInterval = random(0.5, 2.0);
				
				// resurrect subbases
				for (var i:int = 0; i < 4;++i)
				{
					(subBases.members[i] as SubBase).revive();
				}
			}
			
			_spawnInterval -= FlxG.elapsed;
			if (_spawnInterval < 0 && _zombieCounter < _zombieInWave)
			{
				_spawnInterval = random(0.5, 2.0);
				var point:FlxPoint = Environment.spawnPoints[(int)(random(0, 12))];
				var z:Zombie = zombies.getFirstDead() as Zombie;
				
				if (z == null)
				{
					z = new Zombie(point.x, point.y);
					zombies.add(z);
				}
				else
				{
					z.x = point.x; z.y = point.y;
					z.revive();
				}
				
				++_zombieCounter;
			}
			
			// update zombies movement
			
			for each(var zombie:Zombie in zombies.members)
			{
				if (zombie.pathSpeed < 1)
				{
					var root:FlxPoint = zombie.path == null ? new FlxPoint(zombie.x, zombie.y) : zombie.path.tail();
					var node:Node = Environment.nodeContainer.getNode(root);
					var idx:int = (int)(random(0, node.length));
					var pt:FlxPoint = node.nodes[idx];
					var p:FlxPath = new FlxPath(); p.add(pt.x, pt.y);
					zombie.followPath(p, random(30, 100));
				}
			}
		}
		
		private function random(min:Number, max:Number) : Number
		{
			 return Math.random() * (max - min) + min;
		}
		
		private function zombieVsLaser(zombie:Zombie, laser:Beam) : void
		{
			if (!zombie.alive) { return; }
			
			zombie.kill();
			points += 10;
			pointsText.text = points.toString();
			
			++_deadZombieCounter;
		}
		
		private function zombieVsSubBase(zombie:Zombie, subBase:SubBase) : void
		{
			if (!zombie.alive) { return; }
			
			zombie.kill();
			subBase.kill();
			
			++_deadZombieCounter;
			
			// activate base
			if (subBases.countDead() == 4)
			{
				base.activate();
			}
		}
		
		private function zombieVsBase(zombie:Zombie, b:Base) : void
		{
			if (subBases.countDead() != 4) { return; }
			
			b.health -= zombie.damage;
			zombie.kill();
			++_deadZombieCounter;
			
			if (b.health < 0)
			{
				FlxG.switchState(new GameOverState());
			}
		}
		
		private function initTowers() : void
		{
			var xs:Array = new Array(110, 234, 390, 514);
			var ys:Array = new Array(100, 184, 280, 364);
			
			for (var i:int = 0; i < 4;++i)
			{
				for (var j:int = 1; j < 5;++j)
				{
					var t:Tower = new Tower(xs[j - 1], ys[i]);
					t.coordinate = new FlxPoint(j - 1, i);
					t.status(false);
					t.onClick = handleTowerClick;
					towers.add(t);
				}
			}
			
			var b1:SubBase = new SubBase(174, 147);
			var b2:SubBase = new SubBase(454, 147);
			var b3:SubBase = new SubBase(174, 328);
			var b4:SubBase = new SubBase(454, 328);
			
			subBases.add(b1); subBases.add(b2); subBases.add(b3); subBases.add(b4);
		}
	}
}