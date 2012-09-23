package worlds 
{
	import entities.LevelMenuItem;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
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
		
		public function MenuWorld() 
		{
			levelList = new Vector.<LevelMenuItem>();
			var i:uint = 1;
			while (A[getLevelString(i)] != null)
			{
				var itemAngle:Number = (i - 1) * 5;
				levelList.push(new LevelMenuItem(Math.floor(200 * Math.cos(itemAngle * FP.RAD)), Math.floor(200 * Math.sin(itemAngle * FP.RAD)), itemAngle , A[getLevelString(i)]));
				i++;
			}
			
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
		
		protected function selectItem(index:uint):void
		{
			if (index >= levelList.length || index < 0) { return; }
			angle = 360 - levelList[index].angle;
			centerScreenAt(levelList[index].x, levelList[index].y);
			levelList[_currentIndex].selected = false;
			levelList[index].selected = true;
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