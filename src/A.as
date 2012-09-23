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
		
		/** The star pickup. */
		[Embed(source = "../assets/star.png")] public static const STAR:Class;
		
		/** The scrolling background. */
		[Embed(source = "../assets/background.png")] public static const BACKGROUND:Class;
		
		/** The level files. */
		[Embed(source = "../levels/od_01.oel", mimeType = "application/octet-stream")] public static const OD_01:Class;
		[Embed(source = "../levels/od_02.oel", mimeType = "application/octet-stream")] public static const OD_02:Class;
		[Embed(source = "../levels/od_03.oel", mimeType = "application/octet-stream")] public static const OD_03:Class;
	}

}