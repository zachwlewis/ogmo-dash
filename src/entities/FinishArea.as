package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.TiledImage;
	
	/**
	 * The goal for a stage.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class FinishArea extends Entity 
	{
		protected var _image:TiledImage;
		
		public function FinishArea(x:Number, y:Number, width:Number, height:Number) 
		{
			_image = new TiledImage(A.FINISH, width, height);
			setHitbox(width, height);
			
			type = "finish";
			
			super(x, y, _image);
		}
		
	}

}