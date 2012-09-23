package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.GameWorld;
	import worlds.MenuWorld;
	
	// The size of our SWF.
	[SWF(width="512", height="448")]
	
	/**
	 * A game created to learn how to work with FlashPunk and Ogmo Editor.
	 * Using OgmoEditor 2.1.0.1 and FlashPunk 1.6.
	 * @see https://github.com/Draknek/FlashPunk/commit/eb751dd0a51cb5e5c5aea33446a3c51bdb9d4139
	 * @see http://www.ogmoeditor.com/
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class OgmoDash extends Engine 
	{
		
		public function OgmoDash():void 
		{
			// Note that the FlashPunk instance is larger than the SWF.
			// This is to prevent rotation from showing white edges.
			super(800, 800);
		}
		
		override public function init():void 
		{
			super.init();
			trace("FlashPunk version " + FP.VERSION + " started.");
			FP.world = new MenuWorld();
		}
		
	}
	
}