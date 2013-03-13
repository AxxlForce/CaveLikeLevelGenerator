package
{
	import flash.display.Sprite;
	
	public class LevelGeneratorTest extends Sprite
	{
		public function LevelGeneratorTest()
		{
			var levelGenerator:LevelGenerator = new LevelGenerator();
			
			var level:Vector.<Vector.<Tile>> = levelGenerator.calculateMap(64, 24);
			
			printLevel(level);
		}
	
		/**
		 * print the a level to the console by iterating over our 2D array and printing a char representing each tile
		 */
		private function printLevel(level:Vector.<Vector.<Tile>> ):void
		{
			for (var i:int = 0; i < level.length; i++) 
			{
				var line:String = new String();
				
				for (var j:int = 0; j < level[i].length; j++) 
				{
					if (level[i][j].isWall())
					{
						line += getWallCharacter(level[i][j]);
					}
					if (level[i][j].isFloor())
					{
						line += ".";
					}
				}
				trace(line);
			}
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