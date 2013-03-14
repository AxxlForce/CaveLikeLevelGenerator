package
{
	import flash.display.Sprite;
	
	public class LevelGeneratorTest extends Sprite
	{
		public function LevelGeneratorTest()
		{
			var levelGenerator:LevelGenerator = new LevelGenerator();
			
			var level:Level = levelGenerator.generateLevel(64, 24);
			
			trace ("Spawn Point: (" + level.spawnPoint.x + ","  + level.spawnPoint.y + "), Exit Point: (" + level.exitPoint.x + ","  + level.exitPoint.y + ")");
			printLevel(level);
		}
	
		/**
		 * print the a level to the console by iterating over our 2D array and printing a char representing each tile
		 */
		private function printLevel(level:Level):void
		{
			var grid:Vector.<Vector.<Tile>> = level.map.grid;
			
			for (var i:int = 0; i < grid.length; i++) 
			{
				var line:String = new String();
				
				for (var j:int = 0; j < grid[i].length; j++) 
				{
					if (grid[i][j].isWall())
					{
						line += getWallCharacter(grid[i][j]);
					}
					if (grid[i][j].isFloor())
					{
						line += getFloorCharacter(grid[i][j], level);
					}
				}
				trace(line);
			}
		}
		
		private function getFloorCharacter(tile:Tile, level:Level):String
		{
			var spawn:Coordinate = level.spawnPoint;
			var exit:Coordinate = level.exitPoint;
			
			if ( (spawn.x == tile.getXPosition()) && (spawn.y == tile.getYPosition()) )
			{
				return "S";	
			}
			if ( (exit.x == tile.getXPosition()) && (exit.y == tile.getYPosition()) )
			{
				return "E";	
			}
			return ".";
		}
			
		private function getWallCharacter(tile:Tile):String
		{
			switch(tile.getTileID())
			{
				case 0:		// unassinged...
					return "X";
					
				case 1:
					return "o";
					
				case 2:
					return "#";
					
				case 3:
					return "-";
					
				case 4:
					return "_";
					
				case 5:
					return "=";
					
				case 6:
					return "|";
					
				case 7:
					return "|";
					
				case 8:
					return "|";
					
				case 9:
					return "\\";
					
				case 10:
					return "/";
					
				case 11:
					return "/";
					
				case 12:
					return "\\";

				case 13:
					return "A";
					
				case 14:
					return "V";
					
				case 15:
					return ">";
					
				case 16:
					return "<";
			}
		return "";	// we dont go here
		}
	}
}