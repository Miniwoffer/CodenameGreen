package scripts  {
	import flash.events.KeyboardEvent;
	
	import flash.events.MouseEvent;
	
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	import scripts.Ship;
	import scripts.Main;
	import flash.geom.Rectangle;
	import flash.geom.Point;

	public class Player extends MovieClip {
		
		public var myShip:Ship;
		var input:Object ;
		
		public function Player() {
			input = new Object();
			input.up = false;
			input.down = false;
			input.right = false;
			input.left = false;
			input.shoot = false;
			myShip = new Ship(1,new Array(1,0,0));
			Main.getMain().addChild(this);
			// constructor code
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,kUp);
			addEventListener(Event.ENTER_FRAME,update);
		}
		public function update(e:Event){
			var main:Main = Main.getMain();
			if(!main.gamepaused)
			{
			if(input.up)
			{
				myShip.forward();
			}
			if(input.right)
			{
				myShip.turnRight();
			}
			if(input.left)
			{
				myShip.turnLeft();
			}
			if(input.shoot)
			{
				
			}
			var myRect:Rectangle = main.scrollRect;
			myRect.x =  myShip.x-(stage.stageWidth/2);
			myRect.y =  myShip.y-(stage.stageHeight/2);
			main.scrollRect = myRect;
			var myTarget:Point = new Point(mouseX,mouseY)
			myShip.setWeaponAimLocation(myTarget);
			}
		}
		public function kDown(e:KeyboardEvent) {
			switch(e.keyCode)
			{
				case Keyboard.W: case Keyboard.UP:
				trace("up");
					input.up = true;
				break;
				
				case Keyboard.A: case Keyboard.LEFT:
					input.left = true;
				break;

				case Keyboard.S: case Keyboard.DOWN:
					input.down = true;
				break;

				case Keyboard.D: case Keyboard.RIGHT:
					input.right = true;
				break;
				
				case Keyboard.SPACE:
					input.shoot = true;
				break;

			}
		}
		public function kUp(e:KeyboardEvent) {
			switch(e.keyCode)
			{
				case Keyboard.W: case Keyboard.UP:
					input.up = false;
				break;
				
				case Keyboard.A: case Keyboard.LEFT:
					input.left = false;
				break;

				case Keyboard.S: case Keyboard.DOWN:
					input.down = false;
				break;

				case Keyboard.D: case Keyboard.RIGHT:
					input.right = false;
				break;
				
				case Keyboard.SPACE:
					input.shoot = false;
				break;


			}
		}

	}
	
}
