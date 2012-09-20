package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.GameWorld;
	
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
			super(800, 800);
			FP.screen.scale = 1;
			//FP.console.enable();
		}
		
		override public function init():void 
		{
			super.init();
			trace("FlashPunk version " + FP.VERSION + " started.");
			FP.world = new GameWorld;
		}
		
	}
	
}