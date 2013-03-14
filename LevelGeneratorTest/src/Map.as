package
{
	/**
	 * this class is the visual representation of a level. It's a 2D array of Tiles
	 */
	public class Map
	{
		private var _grid:Vector.<Vector.<Tile>>;
		private var _width:int;
		private var _heigth:int;
		
		public function Map(grid:Vector.<Vector.<Tile>>)
		{
			this._grid = grid;
			this._width = grid[0].length;
			this._heigth = grid.length;
		}

		public function get heigth():int
		{
			return _heigth;
		}

		public function get width():int
		{
			return _width;
		}

		public function get grid():Vector.<Vector.<Tile>>
		{
			return _grid;
		}

	}
}