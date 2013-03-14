package
{
	public class MapGenerator
	{
		/** member */
		private var grid:Vector.<Vector.<Tile>>;
		private var grid2:Vector.<Vector.<Tile>>;
		private var size_x:int;
		private var size_y:int;
		
		/** class constants */
		private const FILL_PROBABILITY:Number = 0.4;
		
		/**
		 * this method returns newly calculated level
		 * 
		 * needs some tweaking of how often and with which parameter to call generateMap()
		 */
		public function generateMap(width:int, heigth:int):Map
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
			
			this.determineAllTileTypes();
			
			// map creation done!
			return new Map(grid);
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
				
				grid[yi][0] = new Tile(true, 0, yi);
				grid[yi][size_x - 1] = new Tile(true, size_x - 1, yi);
			}
			
			for (xi = 0; xi < size_x; xi++) {
				
				grid[0][xi] = new Tile(true, xi, 0);
				grid[size_y - 1][xi] = new Tile(true, xi, size_y - 1);
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
		
		/**
		 * determine all tile types
		 */
		private function determineAllTileTypes():void
		{
			for (var y:int = 0; y < size_y; y++)
			{
				for (var x:int = 0; x < size_x; x++)
				{
					// nothing to do if tile is no wall
					if (grid[y][x].isWall() )
					{
						this.determineTileType(grid[y][x]);
					}
				}
			}
		}
		
		/**
		 * determine which type of wall a tile represtents. Currently, there are 16 different tiles
		 */
		private function determineTileType(tile:Tile):void
		{
			if ( !hasWallToTheTop(tile) && !hasWallToTheBottom(tile) && !hasWallToTheLeft(tile) && !hasWallToTheRight(tile) )
			{
				// 	...
				//	.#.
				//	...
				tile.setTileID(1);
			}
			
			if ( hasWallToTheTop(tile) && hasWallToTheBottom(tile) && hasWallToTheLeft(tile) && hasWallToTheRight(tile) )
			{
				//	.#.
				//	###
				//	.#.
				tile.setTileID(2);
			}
			
			// straigth walls
			if ( !hasWallToTheTop(tile) && hasWallToTheBottom(tile) && hasWallToTheLeft(tile) && hasWallToTheRight(tile) )
			{
				// 	.#.
				//	###
				//	...
				tile.setTileID(3);
			}	
			
			if ( hasWallToTheTop(tile) && !hasWallToTheBottom(tile) && hasWallToTheLeft(tile) && hasWallToTheRight(tile) )
			{
				//	...
				//	###
				//	.#.
				tile.setTileID(4);
			}
			
			if ( !hasWallToTheTop(tile) && !hasWallToTheBottom(tile) && hasWallToTheLeft(tile) && hasWallToTheRight(tile) )
			{
				//	...
				//	###
				//	...
				tile.setTileID(5);
			}
			
			if ( hasWallToTheTop(tile) && hasWallToTheBottom(tile) && !hasWallToTheLeft(tile) && hasWallToTheRight(tile) )
			{
				// 	.#.
				//	.##
				//	.#.
				tile.setTileID(6);
			}
			
			if ( hasWallToTheTop(tile) && hasWallToTheBottom(tile) && hasWallToTheLeft(tile) && !hasWallToTheRight(tile) )
			{
				// 	.#.
				//	##.
				//	.#.
				tile.setTileID(7);
			}
			
			if ( hasWallToTheTop(tile) && hasWallToTheBottom(tile) && !hasWallToTheLeft(tile) && !hasWallToTheRight(tile) )
			{
				// 	.#.
				//	.#.
				//	.#.
				tile.setTileID(8);
			}
			
			// diagonal walls
			if ( !hasWallToTheTop(tile) && hasWallToTheBottom(tile) && hasWallToTheLeft(tile) && !hasWallToTheRight(tile) )
			{
				//	...
				//	##.
				//	.#.
				tile.setTileID(9);
			}
			
			if ( !hasWallToTheTop(tile) && hasWallToTheBottom(tile) && !hasWallToTheLeft(tile) && hasWallToTheRight(tile) )
			{
				//	...
				//	.##
				//	.#.
				tile.setTileID(10);
			}
			
			if ( hasWallToTheTop(tile) && !hasWallToTheBottom(tile) && hasWallToTheLeft(tile) && !hasWallToTheRight(tile) )
			{
				//	.#.
				//	##.
				//	...
				tile.setTileID(11);
			}
			
			if ( hasWallToTheTop(tile) && !hasWallToTheBottom(tile) && !hasWallToTheLeft(tile) && hasWallToTheRight(tile) )
			{
				//	.#.
				//	.##
				//	...
				tile.setTileID(12);
			}
			
			// sharp edges
			if ( !hasWallToTheTop(tile) && hasWallToTheBottom(tile) && !hasWallToTheLeft(tile) && !hasWallToTheRight(tile) )
			{
				//	...
				//	.#.
				//	.#.
				tile.setTileID(13);
			}
			
			if ( hasWallToTheTop(tile) && !hasWallToTheBottom(tile) && !hasWallToTheLeft(tile) && !hasWallToTheRight(tile) )
			{
				//	.#.
				//	.#.
				//	...
				tile.setTileID(14);
			}
			
			if ( !hasWallToTheTop(tile) && !hasWallToTheBottom(tile) && hasWallToTheLeft(tile) && !hasWallToTheRight(tile) )
			{
				//	...
				//	##.
				//	...
				tile.setTileID(15);
			}
			
			if ( !hasWallToTheTop(tile) && !hasWallToTheBottom(tile) && !hasWallToTheLeft(tile) && hasWallToTheRight(tile) )
			{
				//	...
				//	.##
				//	...
				tile.setTileID(16);
			}
		}
		
		private function hasWallToTheTop(tile:Tile):Boolean
		{
			var x:int = tile.getXPosition();
			var y:int = tile.getYPosition();
			
			// tile is upper border
			if ( y <= 0 )
			{
				return true;
			}
			
			// normal tile
			return grid[y-1][x].isWall();
		}
		
		private function hasWallToTheBottom(tile:Tile):Boolean
		{
			var x:int = tile.getXPosition();
			var y:int = tile.getYPosition();
			
			// tile is bottom border
			if ( y+1 >= this.size_y )
			{
				return true;
			}
			
			// normal tile
			return grid[y+1][x].isWall();
		}
		
		private function hasWallToTheLeft(tile:Tile):Boolean
		{
			var x:int = tile.getXPosition();
			var y:int = tile.getYPosition();
			
			// tile is left border
			if ( x <= 0 )
			{
				return true;
			}
			
			// normal tile
			return grid[y][x-1].isWall();
		}
		
		private function hasWallToTheRight(tile:Tile):Boolean
		{
			var x:int = tile.getXPosition();
			var y:int = tile.getYPosition();
			
			// tile is right border
			if ( x+1 >= this.size_x )
			{
				return true;
			}
			
			// normal tile
			return grid[y][x+1].isWall();
		}

	}
}