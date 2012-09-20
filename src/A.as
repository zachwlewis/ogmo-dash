package  
{
	/**
	 * Game assets for OgmoDash
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class A 
	{
		/** The player graphic. */
		[Embed(source = "../assets/player.png")] public static const PLAYER:Class;
		
		/** The player graphic. */
		[Embed(source = "../assets/background.png")] public static const BACKGROUND:Class;
		
		/** The level file. */
		[Embed(source = "../levels/tutorial.oel", mimeType = "application/octet-stream")] public static const LEVEL:Class;
	}

}