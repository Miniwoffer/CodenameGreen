package scripts
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;

	import scripts.GameObject;
	import scripts.Ship;
	import scripts.XmlLoader;
	import scripts.MouseHide;
	import scripts.Quest;

	public class Main extends MovieClip
	{
		//A variable used in 
		public var debug = false;
		//A satic function to make the main class easly accsesible to all other classes
		static var main:Main;
		static function getMain():Main{return main;}
		
		//-----------Misc private variables-----------
		var followcamMovieClips:Array;//Used for user interface/HUD/shop/markers
		var gameObjects:Array;//used for collision
		
		var xmlLoader:XmlLoader;//The class that loads the xmlfiles and adds the images to the loader
		var imageLoader:ImageLoader;//loades and stores the images
		var soundLoader:SoundLoader;//loades and stores the sounds
		
		//-----------Misc public variables-----------
		public var gamepaused:Boolean;
		public var player:Player;
		public var shop:Shop;
		public var hud:Hud = new Hud;

		/*-----------Variable forwarding functions-----------
		I used variable forwarding instead of using public variable
		since its considerd to best practice.*/
		public function getXMLLoader():XmlLoader{return xmlLoader;}
		public function getSoundLoader():SoundLoader{return soundLoader;}
		public function getPlayer():Player{return player;}
		public function getShop():Shop{return shop;}
		public function getHud():Hud{return hud;}
		public function getImageLoader():ImageLoader{return imageLoader;}
		
		/*-----------Passive functions-----------
		Functions that return infromation but dosnt make changes*/
		public function getCameraCenter():Point{
			var pnt: Point = new Point();
			pnt.x = scrollRect.x + (stage.stageWidth / 2);
			pnt.y = scrollRect.y + (stage.stageHeight / 2);
			return pnt;
		}
		/*-----------GameObject functions-----------
		Functions that override part of the default code to immploment
		collision for the class GameObject*/
		//collects alle Gameobjects added as a child, and stores it in the variable "GameObjects"
		override public function addChild(child: DisplayObject):DisplayObject{
			var go:GameObject = child as GameObject;
			if (go != null)
			{
				gameObjects.push(go);
			}
			return super.addChild(child);
		}
		override public function addChildAt(child: DisplayObject, i:int):DisplayObject{
			var go:GameObject = child as GameObject;
			if (go != null)
			{
				gameObjects.push(go);
			}
			return super.addChildAt(child,i);
		}
		//Removes any gameobjects removed from children
		override public function removeChild(child: DisplayObject):DisplayObject{
			var go:GameObject = child as GameObject;
			if (go != null)
			{
				for (var i: int = 0; i < gameObjects.length; i++)
				{
					if (gameObjects[i] == go)
					{
						gameObjects.splice(i, 1);
					}
				}
			}
			if(contains(child))
				return super.removeChild(child);
				
			return null;
		}
		
		/*-----------Aktive functions-----------
		Fungsjoner som gjør endringer i classen*/
		
		//leger til ting som skal følge kamera
		public function addFolowCamera(mv: MovieClip)
		{
			followcamMovieClips.push(mv);
		}
		//fjerner som ikke trenger å følge kamera lenger
		public function removeFolowCamera(mv: MovieClip){
			for(var i:int = 0; i < followcamMovieClips.length; i++)
			{
				if(followcamMovieClips[i] == mv)
				{
					followcamMovieClips.splice(i,1);
				}
			}
		}
		//Denne blir fyrt av når startknappen blir trykket
		public function startGame(){
			hud.visible = true;
			gotoAndStop(2);
			spawnWorld();
			MusicScript.setCurrentTrack(MusicScript.idleSound);
			Quest.iniQuest();
			player = new Player();
		}
		//Denne blir fyrt av når spilleren dør og tar seg av å pause spillet og vise gamer over skjermen
		public function endGame(){
			gamepaused = true;
			var ends:endScreen = new endScreen();
			addFolowCamera(ends);
			addChild(ends);
			
		}
		
		//Denne fungsjonen tar av seg spawning og rendereringen av bakgrunnen i verden
		//Den spawner også romstasjonen, men ikke spawning av fiender og quest
		function spawnWorld():void{
			var xmlData = xmlLoader.getXmlData();
			
			
			//et moveclip som midlertidig holder alle elementene i backgrunnen,
			//og blir brukt til å renderere bitmaps som blir backgrunnen
			var bc:MovieClip = new MovieClip();
			
			xmlData = xmlData[0].settings.worldgen;
			
			//litt fancy matte for å passe på at antall stjerner ikke avhenger av størlelsen på kartet
			var spawnMulti:Number = xmlData.mapsize / 1000;
			var stars:int = xmlData.density.stars * spawnMulti;
			var planets:int = xmlData.density.planets * spawnMulti;
			
			//Legger til alle stjernene i movieklippet
			for (var i: int = 0; i < stars; i++){
				var star:Bitmap = imageLoader.getImage(xmlData.images.stars.star[Math.floor(Math.random() * xmlData.images.stars.children().length())].imgnum);
				star.rotation = Math.random() * 360;
				star.x = Math.random() * xmlData.mapsize;
				star.y = Math.random() * xmlData.mapsize;
				randSize = (Math.random() * 0.25) + 0.1;
				star.scaleX = randSize;
				star.scaleY = randSize;
				bc.addChild(star);
			}
			//Legger til alle planeetene i movieklippet
			for (i = 0; i < planets; i++){
				var planet:Bitmap = imageLoader.getImage(xmlData.images.planets.planet[Math.floor(Math.random() * xmlData.images.planets.children().length())].imgnum);//                                                                                             @(･ｪ･｡)@ You found the Code monkey yayyy
				planet.rotation = Math.random() * 360;
				planet.x = Math.random() * xmlData.mapsize;
				planet.y = Math.random() * xmlData.mapsize;
				var randSize = (Math.random() * 0.25) + 0.1;
				planet.scaleX = randSize;
				planet.scaleY = randSize;
				bc.addChild(planet);
			}
			
			var mapsize:int = xmlData.mapsize;
			var mapsammount:int = 1;
			var maps:Array;
			
			//sjeker hvormange deler kartet må deles opp i
			while (mapsize > 1000){
				mapsize = mapsize / 2;
				mapsammount = mapsammount * 2;
			}
			//rendererer movieclipet in i så mange antall bitmaps som ble definert ovenfor
			for (i = 0; i < mapsammount; i++)//X
			{
				for (var j:int = 0; j < mapsammount; j++)//Y
				{
					var bitData:BitmapData = new BitmapData(mapsize,mapsize,true,0);
					var matrix:Matrix = new Matrix();
					matrix.translate(-mapsize*i,-mapsize*j);
					bitData.draw(bc,matrix);
					if(debug)
					{
						var txt:TextField = new TextField();
						txt.textColor = 0xFFFFFF;
						txt.text = "x:"+i+" y:"+j;
						bitData.draw(txt);
					}
					var bitmap:Bitmap = new Bitmap(bitData);
					bitmap.width = mapsize;
					bitmap.height = mapsize;
					bitmap.x = mapsize*i;
					bitmap.y = mapsize*j;
					addChild(bitmap);
				}
				
			}
			
			//Spawner alle romstasjonene på kartet
			for(i = 0; i < xmlData.stations;i++){
				addChild(new SpaceStation(Math.random()*xmlData.mapsize,Math.random()*xmlData.mapsize,0));
			}
		}
		/*-----------Misc functions-----------
		Fungsjoner som ikke passer i de andre katogoriene
		*/
		public function Main(){
			// sets main to the first Main created
			if (main == null){main = this;}
			
			followcamMovieClips = new Array();
			gameObjects = new Array();
			
			
			gamepaused = new Boolean(false);
			
			xmlLoader = new XmlLoader("content/content.xml"); 
			soundLoader = new SoundLoader(); 
			imageLoader = new ImageLoader();
			
			timerMouseHide.addEventListener(TimerEvent.TIMER_COMPLETE, mHide);
			
			addEventListener(Event.ENTER_FRAME, checkMovement);
			addEventListener(Event.ENTER_FRAME, frameEnter);
			
			//for at brukergrenser snittet ikke skal hakke etter kamera så blir de flyttet i EXIT_FRAME og ikke i ENTER_FRAME
			addEventListener(Event.EXIT_FRAME, moveUI);
			
			//vi bruker scrollRecten for å styre hvor kamera er
			scrollRect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			
			//Ser om det finnes noen GameObjects blant childene før contructeren blir kjørt
			//siden da vill ikke override fungsjonen ha kicket inn enda.
			for (var i: int = 0; i < numChildren; i++){
				var go:GameObject = getChildAt(i) as GameObject;
				if (go != null) gameObjects.push(go);
			}
			
			//Lager og setter opp brukergrensersnittet
			shop = new Shop();
			addFolowCamera(shop); addFolowCamera(hud);
			addChild(shop); addChild(hud);
			shop.visible = false; hud.visible = false;
		}
		//Flytter alle brukergrensesnitt elementene
		function moveUI(e: Event){
			var centerpnt:Point = getCameraCenter();
			for (var i: int = followcamMovieClips.length-1; i >= 0; i--)
			{
				followcamMovieClips[i].x = centerpnt.x;
				followcamMovieClips[i].y = centerpnt.y;
				setChildIndex(followcamMovieClips[i],numChildren-1);
			}
		}
		public function frameEnter(e: Event){
			
			//oppdaterer hp baren i venstre hjørne
			if (player != null){
				if (player.getShip() != null)
					hud.hpBar.hpBarVisual.width = (440 / player.getShip().maxHealth) * player.getShip().health;
				else
					hud.hpBar.hpBarVisual.width = 0;
			}
			
			//Sjekker collisjon blant alle GameObjecta
			for (var i: int = 0; i < gameObjects.length; i++){
				for (var j: int = i + 1; j < gameObjects.length; j++){
					
					//variablene er brukt i et system så blant annet vi ikke sjekker kollisjon mellom kuler
					var iIgnore = false;
					var jIgnore = false;
					for (var t: int = 0; t < gameObjects[i].ignore.length; t++){
						if (gameObjects[i].ignore[t] == gameObjects[j].tag){
							iIgnore = true;
						}
					}
					for (t = 0; t < gameObjects[j].ignore.length; t++){
						if (gameObjects[j].ignore[t] == gameObjects[i].tag){
							iIgnore = true;
						}
					}
					if ((!iIgnore || !jIgnore) && gameObjects[i].hitTestObject(gameObjects[j])){
						if (! iIgnore){
							gameObjects[i].onCollision(gameObjects[j]);
						}
						if (! jIgnore){
							gameObjects[j].onCollision(gameObjects[i]);
						}
					}
				}
			}
		}
		// HER KOMMER NÅ MOUSE FUNKSJONEN SOM SKJULER DEN AUTOMATISK
		
		//variabler som tilhører musebevegelses fungsjonene nednfor.
		var switcher:int = 0;
		var posX1:Number = stage.mouseX;
		var posY1:Number = stage.mouseY;
		var posX2:Number = stage.mouseX;
		var posY2:Number = stage.mouseY;
		var timerMouseHide:Timer = new Timer(2000,1);
		
		//sjeker om musa har bevegseg
		function checkMovement(e: Event):void{
			if (switcher == 0)
			{
				posX1 = stage.mouseX;
				posY1 = stage.mouseY;
				switcher = 1;
			}
			else
			{
				posX2 = stage.mouseX;
				posY2 = stage.mouseY;
				switcher = 0;
			}

			if (posX1 == posX2 && posY1 == posY2)
			{
				timerMouseHide.start();
			}
			else
			{
				timerMouseHide.stop();
				MouseHide.mouseToggled = false;
				MouseHide.mouseDownHandler();
			}
		}

		function mHide(e: TimerEvent){MouseHide.mouseDownHandler();}

	}

}