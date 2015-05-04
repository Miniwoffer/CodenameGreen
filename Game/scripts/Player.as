package scripts
{
	import flash.events.KeyboardEvent;

	import flash.events.MouseEvent;

	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.display.MovieClip;

	import scripts.Ship;
	import scripts.Main;
	import scripts.Ai;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.media.Sound;

	public class Player extends MovieClip
	{

		public var myShip:Ship;
		var input:Object;
		var enemy:Array = new Array();
		public var closeToShop:Boolean = false;
		public function Player()
		{
			/*
			for(var i:int = 0; i < 10; i++)
			{
			enemy.push(new Ai(Math.random()*2,new Array(Math.random()*2,Math.random()*2),0,Math.random()*1000,Math.random()*1000));
			}*/
			enemy.push(new Ai(Math.random()*2,new Array(0,0),0,1000,1000));
			input = new Object();
			input.up = false;
			input.down = false;
			input.right = false;
			input.left = false;
			input.shoot = false;
			input.shop = false;
			myShip = new Ship(0,new Array(2,2,2,2));
			myShip.hpBar.visible = false;
			Main.getMain().addChild(this);
			// constructor code;
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,kUp);
			addEventListener(Event.ENTER_FRAME,update);
		}
		public function setShip(shipID:int,weapons:Array)
		{
			myShip.die();
			myShip = new Ship(shipID,weapons);
		}
		public function getShip():Ship
		{
			return myShip;
		}
		public function update(e:Event)
		{

			var main:Main = Main.getMain();
			if (! main.gamepaused && myShip != null)
			{
				var shop:MovieClip = main.getShop();
				if (closeToShop && input.shop)
				{
					shop.visible = true;
					main.gamepaused = true;
				}
				else
				{
					shop.visible = false;
				}
				closeToShop = false;
				if (input.up)
				{
					myShip.forward();
				}
				if (input.right)
				{
					myShip.turnRight();
				}
				if (input.left)
				{
					myShip.turnLeft();
				}
				if (input.shoot)
				{
					myShip.shoot();
				}
				var myRect:Rectangle = main.scrollRect;
				myRect.x =  myShip.x-(stage.stageWidth/2);
				myRect.y =  myShip.y-(stage.stageHeight/2);
				main.scrollRect = myRect;
				var myTarget:Point = new Point(mouseX,mouseY);
				myShip.setWeaponAimLocation(myTarget);
			}
			else
			{
				//stage.resetf
			}
		}
		public function kDown(e:KeyboardEvent)
		{
			switch (e.keyCode)
			{
				case Keyboard.W :
				case Keyboard.UP :
					input.up = true;
					break;

				case Keyboard.A :
				case Keyboard.LEFT :
					input.left = true;
					break;

				case Keyboard.S :
				case Keyboard.DOWN :
					input.down = true;
					break;

				case Keyboard.D :
				case Keyboard.RIGHT :
					input.right = true;
					break;

				case Keyboard.SPACE :
					input.shoot = true;
					break;
				case Keyboard.F :
					input.shop = true;
					break;

			}
		}
		public function kUp(e:KeyboardEvent)
		{
			switch (e.keyCode)
			{
				case Keyboard.W :
				case Keyboard.UP :
					input.up = false;
					break;

				case Keyboard.A :
				case Keyboard.LEFT :
					input.left = false;
					break;

				case Keyboard.S :
				case Keyboard.DOWN :
					input.down = false;
					break;

				case Keyboard.D :
				case Keyboard.RIGHT :
					input.right = false;
					break;

				case Keyboard.SPACE :
					input.shoot = false;
					break;
				case Keyboard.F :
					input.shop = false;
					break;


			}
		}


		var playerCurrency:int = 0;

		public function removeMoney(amount:int)
		{
			var mymeonySound:Sound = Main.getMain().getSoundLoader().getSound(Main.getMain().getXMLLoader().getXmlData().settings.miscsounds.sound[0].soundnum);
			mymeonySound.play();
			playerCurrency -=  amount;

			if (playerCurrency < 0)
			{
				playerCurrency = 0;
			}
			updateMoneyDisp();
		}

		public function addMoney(amount:int)
		{
			var mymeonySound:Sound = Main.getMain().getSoundLoader().getSound(Main.getMain().getXMLLoader().getXmlData().settings.miscsounds.sound[0].soundnum);
			mymeonySound.play();
			playerCurrency +=  amount;
			updateMoneyDisp();
		}

		public function updateMoneyDisp()
		{
			Main.getMain().getHud().moneyDisp.text = "" + playerCurrency;
		}
	}

}