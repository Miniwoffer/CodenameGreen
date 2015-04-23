package scripts  {
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	import scripts.Ship;

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
			myShip = new Ship(1,new Array());
			Main.getMain().addChild(this);
			// constructor code
			Main.getMain().addEventListener(KeyboardEvent.KEY_DOWN,this.kDown);
			Main.getMain().addEventListener(KeyboardEvent.KEY_UP,this.kUp);
			Main.getMain().addEventListener(Event.ENTER_FRAME,this.update);
		}
		public function update(e:Event){
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
		}
		public function kDown(e:KeyboardEvent) {
			switch(e.keyCode)
			{
				case Keyboard.W: case Keyboard.UP:
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
