package 
{
	/**
	 * this class is tile of our level grid. It knows if it's a wall and its X and Y position in the grid
	 */
	public class Tile
	{
		private var tileIsWall:Boolean;
		private var _ID:int;
		private var _x:int;
		private var _y:int;
		
		/**
		 * creates a tile
		 */
		public function Tile(isWall:Boolean, xPos:int, yPos:int)
		{
			this.tileIsWall = isWall;
			this._y = yPos;
			this._x = xPos;
		}
		
		public function get yPosition():int
		{
			return _y;
		}

		public function get xPosition():int
		{
			return _x;
		}

		public function get ID():int
		{
			return _ID;
		}

		public function set ID(value:int):void
		{
			_ID = value;
		}

		public function isFloor():Boolean
		{
			return !tileIsWall;
		}
		public function isWall():Boolean
		{
			return tileIsWall;
		}


	}
}