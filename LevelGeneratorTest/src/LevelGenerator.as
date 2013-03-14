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
			
			var grid:Vector.<Vector.<Tile>> = this.mapGenerator.generateMap(width, heigth);
			var spawnPoint:Coordinate = calculateSpawnPoint(grid);
			var exitPoint:Coordinate = calculateExitPoint(grid);
			
			return new Level(grid, spawnPoint, exitPoint);
		}
		
		public function calculateSpawnPoint(grid:Vector.<Vector.<Tile>>):Coordinate
		{
			return new Coordinate(0,0);
		}
		
		public function calculateExitPoint(grid:Vector.<Vector.<Tile>>):Coordinate
		{
			return new Coordinate(grid.length-1,grid[grid.length-1].length-1);
		}
	}
}
