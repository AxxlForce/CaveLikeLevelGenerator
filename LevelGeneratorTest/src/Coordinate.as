package
{
	public class Coordinate
	{
		private var _x:int;
		private var _y:int;
		
		public function Coordinate(x:int, y:int)
		{
			this._x = x;
			this._y = y;
		}

		public function get y():int
		{
			return _y;
		}

		public function get x():int
		{
			return _x;
		}

	}
}