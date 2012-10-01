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
		
		/** The finish area. */
		[Embed(source = "../assets/finish-line.png")] public static const FINISH:Class;
		
		/** The scrolling background. */
		[Embed(source = "../assets/background.png")] public static const BACKGROUND:Class;
		
		/** The fonts. */
		[Embed(source = '../assets/Orbitron Black.ttf', embedAsCFF = "false", fontFamily = 'orbitron black')] public static const FONT_ORBITRON_BLACK:Class;
		[Embed(source = '../assets/Orbitron Bold.ttf', embedAsCFF = "false", fontFamily = 'orbitron bold')] public static const FONT_ORBITRON_BOLD:Class;
		[Embed(source = '../assets/Orbitron Medium.ttf', embedAsCFF = "false", fontFamily = 'orbitron medium')] public static const FONT_ORBITRON_MEDIUM:Class;
		[Embed(source = '../assets/Orbitron Light.ttf', embedAsCFF = "false", fontFamily = 'orbitron light')] public static const FONT_ORBITRON_LIGHT:Class;
	}

}