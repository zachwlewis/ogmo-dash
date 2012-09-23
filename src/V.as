package  
{
	/**
	 * Game variables.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class V 
	{
		private static var _currentLevel:uint = 0;
		
		public static function get CurrentLevel():uint { return _currentLevel; }
		public static function set CurrentLevel(value:uint):void
		{
			_currentLevel = value;
			// TODO: Save game data.
		}
	}

}