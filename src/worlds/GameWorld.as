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
	public class GameWorld extends RotatableWorld 
	{
		protected var player:Player;
		protected var map:Entity;
		
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
			
			// Add the game entities to GameWorld.
			add(player);
			
			// No need to reference these entities again.
			add(map);
		}
		
		override public function update():void 
		{
			super.update();
			
			// Let the user quit at any time.
			if (Input.pressed(Key.ESCAPE)) FP.world = new MenuWorld();
			
			if (_didLose)
			{
				// The player has lost.
				
				// Slowly rotate the screen.
				angle += 45 * FP.elapsed;
				
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
				centerScreenAt(player.x, player.y);
				angle = 90 - player.angle;
				
				// Check the keyboard for updates and pass them to the player.
				handleInput();
				
				// Check to see if the player ran into a wall.
				handleWallCollision();
				
				// Check to see if the player collected a star.
				handleStarCollision();
				
			}
		} 
		
		/** Parse player input and apply it to the game. */
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
		
		/** If the player collides with the map, remove him and wait for the player to respawn. */
		protected function handleWallCollision():void
		{
			if (map.collideWith(player, 0, 0))
			{
				_didLose = true;
				remove(player);
			}
		}
		
		/** If the player collides with a star, remove the star and increment his map score. */
		protected function handleStarCollision():void
		{
			var star:Star = Star(player.collide("star", player.x, player.y));
			if (star != null)
			{
				remove(star);
				// TODO: Update player's star count.
				// TODO: Play collection animation.
			}
		}
		
		protected function loadMap(mapData:Class):void
		{
			// TODO: Add map creation code.
			var mapXML:XML = FP.getXML(mapData);
			
			// Create our map grid.
			_mapGrid = new Grid(uint(mapXML.@width), uint(mapXML.@height), 32, 32, 0, 0);
			_mapGrid.loadFromString(String(mapXML.Grid), "", "\n");
			
			// Create a player at the player start.
			player = new Player(int(mapXML.Entities.PlayerStart.@x), int(mapXML.Entities.PlayerStart.@y), int(mapXML.Entities.PlayerStart.@angle));
			
			// Pre-align our world to prevent view snapping.
			angle = player.angle;
			
			// TODO: Add code for star and finish line creation.
			for each (var node:XML in mapXML.Entities.Star)
			{
				add(new Star(int(node.@x), int(node.@y)));
			}
		}
		
	}

}