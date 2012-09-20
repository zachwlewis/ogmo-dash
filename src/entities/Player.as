package entities 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.tweens.misc.*;
	import net.flashpunk.utils.*;
	
	/**
	 * Core player movement and rotation logic.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Player extends Entity 
	{
		protected var _ang:int;
		protected var _vx:int;
		protected var _vy:int;
		protected var _image:Image;
		protected const SPEED:Number = 200;
		
		protected var _aTween:AngleTween;
		
		public function get angle():Number { return _image.angle; }
		
		public function Player(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			_image = Image(graphic);
			_image.originX = 14;
			_image.originY = 16;
			_ang = 0;
			_aTween = new AngleTween();
			_aTween.angle = 0;
			addTween(_aTween, false);
			setHitbox(16, 16, 8, 8);
			updateRotation(false);
		}
		
		override public function update():void 
		{
			super.update();
			x += _vx * SPEED * FP.elapsed;
			y += _vy * SPEED * FP.elapsed;
			_image.angle = _aTween.angle;
		}
		
		public function spinLeft():void
		{
			_ang += 90;
			updateRotation();
		}
		
		public function spinRight():void
		{
			_ang -= 90;
			updateRotation();
		}
		
		protected function updateRotation(doTween:Boolean = true):void
		{
			if (_ang >= 360) _ang -= 360;
			else if (_ang < 0) _ang += 360;
			
			_vx = Math.cos(FP.RAD * _ang);
			_vy = Math.sin(FP.RAD * _ang);
			
			if (doTween)
			{
				_aTween.tween(_image.angle, _ang, 0.5, Ease.quintOut);
				_aTween.start();
			}
			else
			{
				_image.angle = _ang;
			}
		}
		
	}

}