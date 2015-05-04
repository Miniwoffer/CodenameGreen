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
			var xmlData = Main.getMain().getXMLLoader().getXmlData().settings.worldgen;
			
			for(var i:int = 0; i < 10; i++)
			{
				enemy.push(new Ai(Math.random()*2,new Array(Math.random()*2,Math.random()*2),0,Math.random()*xmlData.mapsize,Math.random()*xmlData.mapsize));
			}
			input = new Object();
			input.up = false;
			input.down = false;
			input.right = false;
			input.left = false;
			input.shoot = false;
			input.shop = false;
			myShip = new Ship(0,new Array(-1,2,2,2));
			myShip.x = xmlData.mapsize/2;
			myShip.y = xmlData.mapsize/2;
			myShip.hpBar.visible = false;
			Main.getMain().addChild(this);
			// constructor code;
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,kUp);
			addEventListener(Event.ENTER_FRAME,update);
		}
		public function setShip(shipID:int,weapons:Array)
		{
			var lastShip:Ship = myShip;
			myShip = new Ship(shipID,weapons);
			myShip.x = lastShip.x;
			myShip.y = lastShip.y;
			myShip.rotation = lastShip.rotation;
			lastShip.die();
		}
		public function getShip():Ship
		{
			return myShip;
		}
		public function update(e:Event)
		{
			var mapSize = Main.getMain().getXMLLoader().getXmlData().settings.worldgen.mapsize;
			var main:Main = Main.getMain();
			if (! main.gamepaused && myShip != null)
			{
				var shop:MovieClip = main.getShop();
				if (closeToShop && input.shop)
				{
					shop.setVisibility(true);
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
				if(myRect.x < 0)myRect.x = 0;
				if(myRect.y < 0)myRect.y = 0;
				
				if(myRect.x > mapSize-myRect.width)myRect.x = mapSize-myRect.width;
				if(myRect.y > mapSize-myRect.height)myRect.y = mapSize-myRect.height;
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


		public var playerCurrency:int = 11110;
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