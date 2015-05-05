package scripts
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.display.Bitmap;

	import scripts.Ship;
	import scripts.Main;
	import scripts.Ai;
	import scripts.Utilities;
	import scripts.SpaceStation;

	public class Player extends MovieClip{

		public var myShip:Ship;
		var input:Object;
		var enemy:Array = new Array();
		var markers:Array = new Array();
		
		//sjekker om spilleren er nære en romstasjon
		public var closeToShop:Boolean = false;
		
		//Lager en pill som altid peker på target
		public function addMarker(target:MovieClip, type:int = 3){
			var xmlData = Main.getMain().getXMLLoader().getXmlData();
			var image:Bitmap = Main.getMain().getImageLoader().getImage(xmlData[0].settings.worldgen.images.questitems.item[type].imgnum);
			var marker:MovieClip = new MovieClip();
			marker.addChild(image);
			image.x = 50;
			image.y = -image.width/2;
			Main.getMain().addChild(marker);
			Main.getMain().addFolowCamera(marker);
			markers.push([target,marker]);
		}
		//Fjerner pilen
		public function removeMarker(target:MovieClip){
			for(var i:int = 0; i < markers.length;i++)
			{
				if(markers[i][0] == target)
				{
					Main.getMain().removeChild(markers[i][1]);
					Main.getMain().removeFolowCamera(markers[i][1]);
					markers.splice(i,1);
				}
			}
		}
		
		public function Player(){
			var xmlData = Main.getMain().getXMLLoader().getXmlData();
			input = new Object();
			input.up = false;
			input.down = false;
			input.right = false;
			input.left = false;
			input.shoot = false;
			input.shop = false;
			myShip = new Ship(0,new Array(-1,2,2,2));
			//flytter skipet til spilleren til senter av kartet
			myShip.x = xmlData.settings.worldgen.mapsize/2; myShip.y = xmlData.settings.worldgen.mapsize/2;
			
			//gjemer hpbaren som følger med skipet siden vi har en i venstre hjørne
			myShip.hpBar.visible = false;
			var main:Main = Main.getMain();
			main.addChild(this);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,kDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,kUp);
			addEventListener(Event.ENTER_FRAME,update);
			for(var i:int = 0; i < main.numChildren;i++){
				if(main.getChildAt(i) is SpaceStation){
					addMarker(main.getChildAt(i) as MovieClip,2);
				}
			}
			//seter penge displayet til det spilleren starter med
			updateMoneyDisp();
		}
		
		//en fugsjon som erstaters spillerens skip med et nytt, blir brukt av butikken når du kjøper et skip
		public function setShip(shipID:int,weapons:Array){
			var lastShip:Ship = myShip;
			myShip = new Ship(shipID,weapons);
			myShip.x = lastShip.x;
			myShip.y = lastShip.y;
			myShip.rotation = lastShip.rotation;
			lastShip.die();

			
		}
		//en get fungsjon for spillerens skip
		public function getShip():Ship{
			return myShip;
		}
		
		//gjør alt som trengs å oppdateres hver frame
		public function update(e:Event){
			//Spawn more enemies if they are not on the map
			var xmlData = Main.getMain().getXMLLoader().getXmlData();
			for(var i:int = 0; i < enemy.length; i++){
				if(enemy[i].ship.dead){
					enemy.splice(i,1);
				}
			}
			while(enemy.length < 20){
				// DAT PUSH ಠ_ಠ,  ALL THE RANDOM
				// つ ◕_◕ ༽つ GIVE RANDOM PLZ つ ◕_◕ ༽つ
				enemy.push(new Ai(Math.round((Math.random()*(xmlData.ships.children().length()-1))+ 0.5) ,new Array(
																													Math.round((Math.random()*(xmlData.ships.children().length()-0.5))),
																													Math.round((Math.random()*(xmlData.ships.children().length()-0.5))),
																													Math.round((Math.random()*(xmlData.ships.children().length()-0.5))),
																													Math.round((Math.random()*(xmlData.ships.children().length()-0.5))),
																													Math.round((Math.random()*(xmlData.ships.children().length()-0.5))),
																													Math.round((Math.random()*(xmlData.ships.children().length()-0.5)))
																													),0,Math.random()*xmlData.settings.worldgen.mapsize,Math.random()*xmlData.settings.worldgen.mapsize));
			}
			
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
			//Makes the markers point at their targets
			for(i = 0; i < markers.length;i++){
				markers[i][1].rotation = Utilities.getRotationTwoPoints(new Point(markers[i][1].x,markers[i][1].y),new Point(markers[i][0].x,markers[i][0].y));
			}
			
		}
		
		//Holder oversikti på når spilleren trykker en knapp
		public function kDown(e:KeyboardEvent){
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
		
		//Holder oversikit på når spilleren slipper en keyboard trykk
		public function kUp(e:KeyboardEvent){
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

		//Spillerens pengepung
		public var playerCurrency:int = 11110;
		
		//fjerner penger fra lomeboka og spiller av en lyd
		public function removeMoney(amount:int){
			var mymeonySound:Sound = Main.getMain().getSoundLoader().getSound(Main.getMain().getXMLLoader().getXmlData().settings.miscsounds.sound[0].soundnum);
			mymeonySound.play();
			playerCurrency -=  amount;

			if (playerCurrency < 0)
			{
				playerCurrency = 0;
			}
			updateMoneyDisp();
		}
		//leger til penger og spiller en lyd
		public function addMoney(amount:int){
			var mymeonySound:Sound = Main.getMain().getSoundLoader().getSound(Main.getMain().getXMLLoader().getXmlData().settings.miscsounds.sound[0].soundnum);
			mymeonySound.play();
			playerCurrency +=  amount;
			updateMoneyDisp();
		}
		//oppdaterer textboksen i HUDen til å vise hvor mye penger spilleren har
		public function updateMoneyDisp(){
			Main.getMain().getHud().moneyDisp.text = String(playerCurrency);
		}
	}

}