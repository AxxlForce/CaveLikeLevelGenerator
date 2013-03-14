package
{
	public class Level
	{
		private var _grid:Vector.<Vector.<Tile>>;
		private var _width:int;
		private var _heigth:int;
		private var _spawnPoint:Coordinate;
		private var _exitPoint:Coordinate;
		
		public function Level(grid:Vector.<Vector.<Tile>>, spawnPoint:Coordinate, exitPoint:Coordinate)
		{
			this._grid = grid;
			this._width = grid[0].length;
			this._heigth = grid.length;
			this._spawnPoint = spawnPoint;
			this._exitPoint = exitPoint;
		}

		public function get exitPoint():Coordinate
		{
			return _exitPoint;
		}

		public function get spawnPoint():Coordinate
		{
			return _spawnPoint;
		}

		public function set spawnPoint(value:Coordinate):void
		{
			_spawnPoint = value;
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
