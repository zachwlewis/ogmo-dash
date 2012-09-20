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
		protected var _speed:Number;
		protected var _aTween:AngleTween;
		
		/** The angle the Player is facing. */
		public function get angle():Number { return _image.angle; }
		public function set angle(value:Number):void
		{
			_ang = value;
			updateRotation(false);
		}
		
		/** The speed of the Player. */
		public function get speed():Number { return _speed; }
		public function set speed(value:Number):void
		{
			_speed = value;
		}
		
		public function Player(x:Number=0, y:Number=0, angle:Number = 0, speed:Number = 200) 
		{
			// Set initial conditions.
			this.x = x;
			this.y = y;
			_ang = angle;
			_speed = speed;
			
			// Set up the player's image.
			_image = new Image(A.PLAYER);
			_image.originX = 14;
			_image.originY = 16;
			
			// Place the Player on the topmost layer.
			layer = -1;			
			
			// Set the tween for smooth angle movement.
			_aTween = new AngleTween();
			_aTween.angle = _ang;
			addTween(_aTween, false);
			
			// Set the hitbox for the player.
			setHitbox(16, 16, 8, 8);
			
			// Calculate the movement direction and image rotation without
			// tweening.
			updateRotation(false);
			
			super(x, y, _image);
		}
		
		override public function update():void 
		{
			super.update();
			
			// Move the player based on the direction and speed.
			x += _vx * _speed * FP.elapsed;
			y += _vy * _speed * FP.elapsed;
			
			// Update the angle of the graphic based on the tween's current
			// angle.
			_image.angle = _aTween.angle;
		}
		
		/** Rotate the player left. */
		public function spinLeft():void
		{
			_ang += 90;
			updateRotation();
		}
		
		/** Rotate the player right. */
		public function spinRight():void
		{
			_ang -= 90;
			updateRotation();
		}
		
		/**
		 * Update the rotation of the player and kick off a tween to smooth the
		 * transition.
		 * 
		 * @param	doTween TRUE if the player should tween his angle, FALSE if
		 * he should snap.
		 */
		protected function updateRotation(doTween:Boolean = true):void
		{
			// Normalize the player's angle from [0, 360).
			if (_ang >= 360) _ang -= 360;
			else if (_ang < 0) _ang += 360;
			
			// Get the direction of travel based on _ang.
			_vx = Math.cos(FP.RAD * _ang);
			_vy = Math.sin(FP.RAD * _ang);
			
			if (doTween)
			{
				// Set up a tween from the current angle to the current _ang
				// and start it.
				_aTween.tween(_image.angle, _ang, 0.5, Ease.quintOut);
				_aTween.start();
			}
			else
			{
				// Snap the image and the tween to the desired angle.
				_image.angle = _ang;
				_aTween.angle = _ang;
			}
		}
		
	}

}