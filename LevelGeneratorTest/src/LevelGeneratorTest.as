package
{
	import flash.display.Sprite;
	
	public class LevelGeneratorTest extends Sprite
	{
		public function LevelGeneratorTest()
		{
			var levelGenerator:LevelGenerator = new LevelGenerator();
			
			var level:Array = levelGenerator.calculateMap(64, 24);
			
			printLevel(level);
		}
	
		/**
		 * print the a level to the console by iterating over our 2D array and printing a char representing each tile
		 */
		private function printLevel(level:Array):void
		{
			for (var i:int = 0; i < level.length; i++) 
			{
				var line:String = new String();
				
				for (var j:int = 0; j < level[i].length; j++) 
				{
					if (level[i][j].isWall())
					{
						line += "#";
					}
					if (level[i][j].isFloor())
					{
						line += ".";
					}
				}
				trace(line);
			}
		}
	}
}