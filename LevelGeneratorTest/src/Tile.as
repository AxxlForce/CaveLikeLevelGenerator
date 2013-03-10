package 
{
	/**
	 * this class is tile of our level grid. It knows if it's a wall and its X and Y position in the grid
	 */
	public class Tile
	{
		private var tileIsWall:Boolean;
		private var xPosition:int;
		private var yPosition:int;
		
		/**
		 * creates a tile
		 */
		public function Tile(isWall:Boolean, xPos:int, yPos:int)
		{
			this.tileIsWall = isWall;
			this.yPosition = yPos;
			this.xPosition = xPos;
		}
		
		/** getter methods */
		public function isFloor():Boolean
		{
			return !tileIsWall;
		}
		public function isWall():Boolean
		{
			return tileIsWall;
		}
		public function getXPosition():int
		{
			return this.xPosition;
		}
		public function getYPosition():int
		{
			return this.yPosition;
		}
	}
}