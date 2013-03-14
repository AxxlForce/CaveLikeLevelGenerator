package
{
	public class Level
	{
		private var _map:Map;
		private var _spawnPoint:Coordinate;
		private var _exitPoint:Coordinate;
		
		public function Level(map:Map, spawnPoint:Coordinate, exitPoint:Coordinate)
		{
			this._map = map;
			this._spawnPoint = spawnPoint;
			this._exitPoint = exitPoint;
		}

		public function get map():Map
		{
			return _map;
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
	}
}
