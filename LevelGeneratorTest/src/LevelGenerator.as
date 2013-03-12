package 
{
	/**
	 * this is a factory class for creating cave like levels
	 * 
	 * however in it's current configuration there is no guarantee of connectedness...
	 */
	public class LevelGenerator
	{
		// member variables
		private var grid:Vector.<Vector.<Tile>>;
		private var grid2:Vector.<Vector.<Tile>>;
		
		private var size_x:int;
		private var size_y:int;
		
		private const FILL_PROBABILITY:Number = 0.4;
		
		/**
		 * this method returns newly calculated level
		 * 
		 * needs some tweaking of how often and with which parameter to call generateMap()
		 */
		public function calculateMap(width:int, heigth:int):Vector.<Vector.<Tile>>
		{
			size_x = width;
			size_y = heigth;
			
			this.initMap();
			
			// this is the configuration suggested by the author of the algorithm... ok for now
			//
			//	Winit(p) = rand[0,100) < 40
			//	Repeat 4: W?(p) = R1(p) ? 5 || R2(p) ? 2
			//	Repeat 3: W?(p) = R1(p) ? 5 
			
			for (var i:int = 0; i < 4; i++) 
			{
				this.processAlgorithm(5, 2);
			}
			for (var j:int = 0; j < 3; j++) 
			{
				this.processAlgorithm(5, -1);
			}
			
			// level creation done!
			return grid;
		}
		
		/**
		 * creates random tile with a certain probability
		 */
		private function getRandomTileForPosition(x:int, y:int):Tile
		{
			var randomRounded : Number = Math.random();
			
			if (randomRounded < FILL_PROBABILITY) 
			{
				return new Tile(true, x, y);
				
			} else 
			{
				return new Tile(false, x, y);
			}
		}
		
		/**
		 * allocates array and fills it with initial values
		 */
		private function initMap():void 
		{
			// create two 2D arrays
			grid = new  Vector.<Vector.<Tile>>(size_y);
			grid2 = new Vector.<Vector.<Tile>>(size_y);
			
			for (var i:int = 0; i < grid.length; i++) 
			{
				grid[i] = new Vector.<Tile>(size_x);
				grid2[i] = new Vector.<Tile>(size_x);
			}
			
			var xi:int, yi:int;
			
			for (yi = 1; yi < size_y - 1; yi++) {
				
				for (xi = 1; xi < size_x - 1; xi++) {
					
					grid[yi][xi] = getRandomTileForPosition(xi, yi);
				}
			}
			
			for (yi = 0; yi < size_y; yi++) {
				
				for (xi = 0; xi < size_x; xi++) {
					
					grid2[yi][xi] = new Tile(true, xi, yi);
				}
			}
			
			for (yi = 0; yi < size_y; yi++) {
				
				grid[yi][0] = new Tile(true, xi, yi);
				grid[yi][size_x - 1] = new Tile(true, xi, yi);
			}
			
			for (xi = 0; xi < size_x; xi++) {
				
				grid[0][xi] = new Tile(true, xi, yi);
				grid[size_y - 1][xi] = new Tile(true, xi, yi);
			}
		}
		
		/**
		 * actual algorithm by Jim Babckock
		 * 
		 * see: http://roguebasin.roguelikedevelopment.org/index.php?title=Cellular_Automata_Method_for_Generating_Random_Cave-Like_Levels
		 */
		private function processAlgorithm(r1_cutoff:int, r2_cutoff:int):void
		{
			var xi:int, yi:int, ii:int, jj:int;
			
			for (yi = 1; yi < size_y - 1; yi++)
			{
				
				// first block
				for (xi = 1; xi < size_x - 1; xi++) 
				{
					var adjcount_r1:int = 0, adjcount_r2:int = 0;
					
					for (ii = -1; ii <= 1; ii++)
					{
						for (jj = -1; jj <= 1; jj++) 
						{
							if (grid[yi + ii][xi + jj].isWall() )
							{
								adjcount_r1++;
							}
						}
					}	// end of first block
					
					// second block
					for (ii = yi - 2; ii <= yi + 2; ii++)
					{
						for (jj = xi - 2; jj <= xi + 2; jj++) 
						{
							if (Math.abs(ii - yi) == 2 && Math.abs(jj - xi) == 2)	
							{
								continue;
							}
							if (ii < 0 || jj < 0 || ii >= size_y || jj >= size_x)
							{
								continue;
							}
							if (grid[ii][jj].isWall() )
							{
								adjcount_r2++;
							}
						}
					}	// end of second block
					
					if (adjcount_r1 >= r1_cutoff || adjcount_r2 <= r2_cutoff)
					{
						grid2[yi][xi] = new Tile(true, xi, yi);
					}
					else
					{
						grid2[yi][xi] = new Tile(false, xi, yi);
					}
				}
			}
			
			for (yi = 1; yi < size_y - 1; yi++)
			{
				for (xi = 1; xi < size_x - 1; xi++)
				{
					if (grid2[yi][xi].isWall())
					{
						grid[yi][xi] = new Tile(true, xi, yi);
					}
					else
					{
						grid[yi][xi] = new Tile(false, xi, yi);
					}
				}
			}	
		}
	}
}