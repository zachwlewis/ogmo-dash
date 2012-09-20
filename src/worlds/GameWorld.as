package worlds 
{
	import entities.*;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.masks.*;
	import net.flashpunk.utils.*;
	
	/**
	 * Core game world logic.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class GameWorld extends World 
	{
		protected var player:Player;
		protected var background:Backdrop;
		protected var _mapGrid:Grid;
		protected var _mapImage:Image;
		protected var map:Entity;
		protected var _didLose:Boolean;
		protected var _mapData:Class;
		
		public function GameWorld(mapData:Class = null) 
		{
			super();
			_mapData = mapData;
			player = new Player(100, 100, new Image(A.PLAYER));
			player.layer = -1;
			background = new Backdrop(A.BACKGROUND, true, true);
			_didLose = false;
			if (map != null)
			{
				// Load the provided map file.
				loadMap(_mapData);
			}
			else
			{
				// Create a debug map.
				_mapGrid = new Grid(1280, 1280, 32, 32, 0, 0);
				_mapGrid.usePositions = true;
				_mapGrid.setRect(0, 0, 1280, 1280, true);
				_mapGrid.setRect(32, 32, 1216, 1216, false);
				player.x = 640;
				player.y = 640;
			}
			
			_mapImage = new Image(_mapGrid.data);
			map = new Entity(0, 0, _mapImage, _mapGrid);
			_mapImage.scale = 32;
		}
		
		override public function begin():void 
		{
			super.begin();
			add(player);
			addGraphic(background, 1);
			
			addGraphic(_mapImage, 0);
			FP.screen.x = (C.GAME_WIDTH - FP.screen.width) * 0.5;
			FP.screen.y = (C.GAME_HEIGHT - FP.screen.height) * 0.5;
			FP.screen.originX = FP.screen.width * 0.5;
			FP.screen.originY = FP.screen.height * 0.5;
			FP.screen.smoothing = true;
		}
		
		override public function update():void 
		{
			super.update();
			if (_didLose)
			{
				// Player has died. Wait for respawn.
				FP.screen.angle += 45 * FP.elapsed;
				if (Input.pressed(Key.SPACE))
				{
					FP.world = new GameWorld(_mapData);
				}
			}
			else
			{	
				camera.x = player.x - FP.screen.width * 0.5;
				camera.y = player.y - FP.screen.height * 0.5;
				FP.screen.angle = 90 - player.angle;
				handleInput();
				if (map.collideWith(player, 0, 0))
				{
					_didLose = true;
					remove(player);
				}
			}
		}
		
		protected function handleInput():void
		{
			if (Input.pressed(Key.LEFT)) player.spinLeft();
			else if (Input.pressed(Key.RIGHT)) player.spinRight();
		}
		
		protected function loadMap(mapData:Class):void
		{
			// TODO: Add map creation code.
		}
		
	}

}