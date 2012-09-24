package worlds 
{
	import entities.LevelMenuItem;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.tweens.motion.CircularMotion;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * The main menu of the game.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class MenuWorld extends RotatableWorld 
	{
		protected var levelList:Vector.<LevelMenuItem>;
		protected var _currentIndex:uint;
		protected var _menuTween:MultiVarTween;
		protected var _cx:Number;
		protected var _cy:Number;
		protected var _ang:Number;
		
		public function get cx():Number { return _cx; }
		public function set cx(value:Number):void { _cx = value; }

		public function get cy():Number { return _cy; }
		public function set cy(value:Number):void { _cy = value; }

		public function get ang():Number { return _ang; }
		public function set ang(value:Number):void { _ang = value; }
		
		public function MenuWorld() 
		{
			levelList = new Vector.<LevelMenuItem>();
			_menuTween = new MultiVarTween();
			addTween(_menuTween, false);
			var i:uint = 1;
			while (A[getLevelString(i)] != null)
			{
				var itemAngle:Number = (i - 1) * 15;
				levelList.push(new LevelMenuItem(200 * Math.cos(itemAngle * FP.RAD), 200 * Math.sin(itemAngle * FP.RAD), itemAngle , A[getLevelString(i)]));
				i++;
			}
			_cx = 200;
			_cy = 0;
			_ang = 0;
			_currentIndex = 0;
		}
		
		override public function begin():void 
		{
			super.begin();
			for each (var l:LevelMenuItem in levelList)
			{
				add(l);
			}
			
			selectItem(V.CurrentLevel);
		}
		
		override public function update():void 
		{
			super.update();
			
			var i:int = 0;
			
			//if (_menuTween.active)
			//{
				angle = _ang;
				centerScreenAt(_cx, _cy);
			//}
			
			if (Input.pressed(Key.SPACE))
			{
				load(_currentIndex);
			}
			else
			{
				if (Input.pressed(Key.UP)) i++;
				if (Input.pressed(Key.DOWN)) i--;
				
				selectItem(_currentIndex + i);
			}
		}
		
		protected function selectItem(index:int):void
		{
			// Prevent out-of-bounds level selection.
			if (index >= levelList.length) { index = levelList.length - 1; }
			else if (index < 0) { index = 0; }
			
			// Update the screen rotation and position.
			_menuTween.tween(this, { cx:levelList[index].x, cy:levelList[index].y, ang:(360 - levelList[index].angle) }, 0.5, Ease.quintOut);
			_menuTween.start();
			
			// Deselect the previous level and select the current level.
			levelList[_currentIndex].selected = false;
			levelList[index].selected = true;
			
			// Store our new index.
			_currentIndex = index;
		}
		
		protected function getLevelString(index:int):String
		{
			var s:String = "OD_";
			if (index < 10) { s += "0"; }
			s += index.toString();
			return s;
		}
		
		protected function load(index:int):void
		{
			V.CurrentLevel = index;
			FP.world = new GameWorld(levelList[index].data);
		}
		
	}

}