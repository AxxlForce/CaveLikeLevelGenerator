package 
{
	
	/**
	 * this is a factory class for creating cave like levels
	 * 
	 * however in it's current configuration there is no guarantee of connectedness...
	 */
	public class LevelGenerator
	{
		/** member */
		private var mapGenerator:MapGenerator;
		
		/**
		 * calculates a tile grid, spawn point and exit point for an level
		 */
		public function generateLevel(width:int, heigth:int):Level
		{
			this.mapGenerator = new MapGenerator();
			
			var map:Map = this.mapGenerator.generateMap(width, heigth);
			var spawnPoint:Coordinate = calculateSpawnPoint(map);
			var exitPoint:Coordinate = calculateExitPoint(map);
			
			return new Level(map, spawnPoint, exitPoint);
		}
		
		public function calculateSpawnPoint(map:Map):Coordinate
		{
			var grid:Vector.<Vector.<Tile>> = map.grid;
			
			for (var y:int = 0; y < map.heigth; y++)
			{
				for (var x:int = 0; x < map.width; x++)
				{
					if ( grid[y][x].isFloor() )
					{
						return  new Coordinate(x, y);
					}
				}
			}
			throw new Error("unable to generate spawn point!");
		}
		
		public function calculateExitPoint(map:Map):Coordinate
		{
			var grid:Vector.<Vector.<Tile>> = map.grid;
			
			for (var y:int = map.heigth-1; y > 0; y--)
			{
				for (var x:int = map.width-1; x > 0; x--)
				{
					if ( grid[y][x].isFloor() )
					{
						return new Coordinate(x, y);
					}
				}
			}
			throw new Error("unable to generate exit point!");
		}
	}
}
