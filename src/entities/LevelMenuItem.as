package entities 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	
	/**
	 * A menu item in the level select menu.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class LevelMenuItem extends Entity 
	{
		protected var _name:String;
		protected var _angle:Number;
		protected var _data:Class;
		protected var _text:Text;
		protected var _selected:Boolean;
		
		public function get levelName():String { return _name; }
		public function get angle():Number { return _angle; }
		public function get data():Class { return _data; }
		
		
		
		public function LevelMenuItem(x:Number, y:Number, angle:Number, levelData:Class)
		{
			generateMetadata(levelData);
			_text = new Text(levelName, 0, 0, { font:"orbitron black", size:36 } );
			_angle = angle;
			_text.angle = _angle;
			_selected = false;
			super(x, y, _text);
		}
		
		protected function generateMetadata(xmlData:Class):void
		{
			_data = xmlData;
			
			var xml:XML = FP.getXML(data);
			_name = xml.@Name;
		}
		
		public function get selected():Boolean { return _selected; }
		public function set selected(value:Boolean):void
		{
			_selected = value;
			if (_selected) { _text.color = 0xFDE06F; }
			else { _text.color = 0xffffff; }
		}
		
	}

}