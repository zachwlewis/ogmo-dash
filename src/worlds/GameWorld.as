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
		protected var map:Entity;
		protected var background:Backdrop;
		
		protected var _mapGrid:Grid;
		protected var _mapImage:Image;
		protected var _didLose:Boolean;
		protected var _mapData:Class;
		
		public function GameWorld(mapData:Class = null) 
		{
			super();
			
			// Save our data.
			_mapData = mapData;
			
			// Set initial conditions.
			_didLose = false;
			
			if (mapData != null)
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
				player = new Player(640, 640);
			}
			
			// Create tiled background for movement reference.
			background = new Backdrop(A.BACKGROUND, true, true);
			
			// Create an image based on the map's data and scale it accordingly.
			_mapImage = new Image(_mapGrid.data);
			_mapImage.scale = 32;
			
			// Create a map entity to render and check collision with.
			map = new Entity(0, 0, _mapImage, _mapGrid);
		}
		
		/* Called when World is switch to, and set to the currently active world. */
		override public function begin():void 
		{
			super.begin();
			
			// Set our screen for rotation.
			FP.screen.x = (C.GAME_WIDTH - FP.screen.width) * 0.5;
			FP.screen.y = (C.GAME_HEIGHT - FP.screen.height) * 0.5;
			FP.screen.originX = FP.screen.width * 0.5;
			FP.screen.originY = FP.screen.height * 0.5;
			FP.screen.smoothing = true;
			
			// Add the game entities to GameWorld.
			add(player);
			
			// No need to reference these entities again.
			addGraphic(background, 1);
			add(map);
		}
		
		override public function update():void 
		{
			super.update();
			if (_didLose)
			{
				// The player has lost.
				
				// Slowly rotate the screen.
				FP.screen.angle += 45 * FP.elapsed;
				
				// When space is pressed, create a new GameWorld with the
				// current map.
				if (Input.pressed(Key.SPACE))
				{
					FP.world = new GameWorld(_mapData);
				}
			}
			else
			{	
				// The player has not lost.
				
				// Update the camera and screen to match the player and keep him
				// facing forward.
				camera.x = player.x - FP.screen.width * 0.5;
				camera.y = player.y - FP.screen.height * 0.5;
				FP.screen.angle = 90 - player.angle;
				
				// Check the keyboard for updates and pass them to the player.
				handleInput();
				
				// If the player collides with the map, remove him and wait to
				// respawn.
				if (map.collideWith(player, 0, 0))
				{
					_didLose = true;
					remove(player);
				}
			}
		}
		
		protected function handleInput():void
		{
			// Check the left and right input and save the sum to n.
			// This way, if the user presses both rotations simultaneously,
			// he won't spin at all.
			var n:int = 0
			if (Input.pressed(Key.LEFT)) n--;
			if (Input.pressed(Key.RIGHT)) n++;
			
			// Based on n, determine if the player should spin.
			if (n != 0)
			{
				if (n < 0) player.spinLeft();
				else player.spinRight();
			}
		}
		
		protected function loadMap(mapData:Class):void
		{
			// TODO: Add map creation code.
		}
		
	}

}