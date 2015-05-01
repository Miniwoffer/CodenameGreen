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

	//Laster in alle third party Scripts
	import thirdparty.CollisionTest;
	import scripts.GameObject;
	import scripts.Ship;
	import scripts.XmlLoader;
	import scripts.MouseHide;
	import flash.geom.Point;
	import flash.geom.Matrix;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;

	public class Main extends MovieClip
	{

		public var debug = true;
		private var followcamMovieClips:Array;
		private var colTester:CollisionTest;
		private var gameObjects:Array;

		private var xmlLoader:XmlLoader;
		private var imageLoader:ImageLoader;
		private var soundLoader:SoundLoader;

		public var gamepaused:Boolean;
		static var main:Main;
		public var player:Player;
		public var shop:Shop;
		public var hud:Hud = new Hud  ;


		static function getMain():Main
		{
			return main;
		}
		public function Main()
		{
			// constructor code
			if (main == null)
			{
				main = this;
			}
			followcamMovieClips = new Array();
			addFolowCamera(hud);
			addChild(hud);
			hud.visible = false;
			gamepaused = new Boolean(false);
			xmlLoader = new XmlLoader("content/content.xml");
			soundLoader = new SoundLoader();
			imageLoader = new ImageLoader();
			timerMouseHide.addEventListener(TimerEvent.TIMER_COMPLETE, mHide);
			gameObjects = new Array();
			stage.addEventListener(Event.ENTER_FRAME, checkMovement);
			stage.addEventListener(Event.EXIT_FRAME, moveUI);
			colTester = new CollisionTest();
			scrollRect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			for (var i: int = 0; i < numChildren; i++)
			{
				var go:GameObject = getChildAt(i) as GameObject;
				if (go != null)
				{
					gameObjects.push(go);
				}
			}
			addEventListener(Event.ENTER_FRAME, frameEnter);

			shop = new Shop();
			shop.visible = false;
			addChild(shop);
		}
		public function startGame()
		{
			hud.visible = true;
			gotoAndStop(2);
			player = new Player();
			spawnWorld();
			MusicScript.setCurrentTrack(MusicScript.idleSound);
		}

		//a Override for the addChild function so all GameObjects gets added to a seperate list that cheks for collision.
		//

		override public function addChild(child: DisplayObject):DisplayObject
		{
			var go:GameObject = child as GameObject;
			if (go != null)
			{
				gameObjects.push(go);
			}
			return super.addChild(child);
		}
		override public function addChildAt(child: DisplayObject, i:int):DisplayObject
		{
			var go:GameObject = child as GameObject;
			if (go != null)
			{
				gameObjects.push(go);
			}
			return super.addChildAt(child,i);
		}
		override public function removeChild(child: DisplayObject):DisplayObject
		{
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
			return super.removeChild(child);
		}
		public function getCameraCenter():Point
		{
			var pnt: Point = new Point();
			pnt.x = scrollRect.x + (stage.stageWidth / 2);
			pnt.y = scrollRect.y + (stage.stageHeight / 2);
			return pnt;
		}
		public function addFolowCamera(mv: MovieClip)
		{
			followcamMovieClips.push(mv);
		}
		public function moveUI(e: Event)
		{
			var centerpnt:Point = getCameraCenter();
			for (var i: int = 0; i < followcamMovieClips.length; i++)
			{
				followcamMovieClips[i].x = centerpnt.x;
				followcamMovieClips[i].y = centerpnt.y;
			}
		}
		public function getHud():Hud
		{
			return hud;
		}
		public function frameEnter(e: Event)
		{
			if (player != null)
			{
				if (player.getShip() != null)
				{
					hud.hpBar.hpBarVisual.width = (440 / player.getShip().maxHealth) * player.getShip().health;
				}
				else
				{
					hud.hpBar.hpBarVisual.width = 0;
				}
			}
			for (var i: int = 0; i < gameObjects.length; i++)
			{
				for (var j: int = i + 1; j < gameObjects.length; j++)
				{
					var iIgnore = false;
					var jIgnore = false;
					for (var t: int = 0; t < gameObjects[i].ignore.length; t++)
					{
						if (gameObjects[i].ignore[t] == gameObjects[j].tag)
						{
							iIgnore = true;
						}
					}
					for (t = 0; t < gameObjects[j].ignore.length; t++)
					{
						if (gameObjects[j].ignore[t] == gameObjects[i].tag)
						{
							iIgnore = true;
						}
					}//if ((!iIgnore || !jIgnore) && colTester.complex(gameObjects[i], gameObjects[j])) 
					if ((!iIgnore || !jIgnore) && gameObjects[i].hitTestObject(gameObjects[j]))
					{
						if (! iIgnore)
						{
							gameObjects[i].onCollision(gameObjects[j]);
						}
						if (! jIgnore)
						{
							gameObjects[j].onCollision(gameObjects[i]);
						}
					}
				}
			}
		}
		public function getXMLLoader():XmlLoader
		{
			return xmlLoader;
		}
		public function getSoundLoader():SoundLoader
		{
			return soundLoader;
		}
		public function getPlayer():Player
		{
			return player;
		}
		public function getShop():Shop
		{
			return shop;
		}
		public function spawnWorld():void
		{
			var xmlData = xmlLoader.getXmlData();
			var bc:MovieClip = new MovieClip();
			xmlData = xmlData[0].settings.worldgen;
			var spawnMulti:int = xmlData.mapsize / 1000;
			var stars:int = xmlData.density.stars * spawnMulti;
			var planets:int = xmlData.density.planets * spawnMulti;
			for (var i: int = 0; i < stars; i++)
			{
				var star:Bitmap = imageLoader.getImage(xmlData.images.stars.star[Math.floor(Math.random() * xmlData.images.stars.children().length())].imgnum);
				star.rotation = Math.random() * 360;
				star.x = Math.random() * xmlData.mapsize;
				star.y = Math.random() * xmlData.mapsize;
				randSize = (Math.random() * 0.25) + 0.1;
				star.scaleX = randSize;
				star.scaleY = randSize;
				bc.addChild(star);
			}
			for (i = 0; i < planets; i++)
			{
				var planet:Bitmap = imageLoader.getImage(xmlData.images.planets.planet[Math.floor(Math.random() * xmlData.images.planets.children().length())].imgnum);
				planet.rotation = Math.random() * 360;
				planet.x = Math.random() * xmlData.mapsize;
				planet.y = Math.random() * xmlData.mapsize;
				var randSize = (Math.random() * 0.25) + 0.1;
				planet.scaleX = randSize;
				planet.scaleY = randSize;
				bc.addChild(planet);
			}
			var makingMap:Boolean = true;
			var mapsize:int = xmlData.mapsize;
			var mapsammount:int = 1;
			var maps:Array;
			while (mapsize > 1000)
			{
				mapsize = mapsize / 2;
				mapsammount = mapsammount * 2;
			}
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
					addChildAt(bitmap,0);
				}
				
			}
			for(i = 0; i < xmlData.stations;i++)
			{
				addChildAt(new SpaceStation(Math.random()*xmlData.mapsize,Math.random()*xmlData.mapsize,0),0);
			}
			//addChildAt(bc,0);
		}
		public function getImageLoader():ImageLoader
		{
			return imageLoader;
		}
		// HER KOMMER NÅ MOUSE FUNKSJONEN SOM SKJULER DEN AUTOMATISK
		var switcher:int = 0;
		var posX1:Number = stage.mouseX;
		var posY1:Number = stage.mouseY;
		var posX2:Number = stage.mouseX;
		var posY2:Number = stage.mouseY;
		var timerMouseHide:Timer = new Timer(2000,1);

		function checkMovement(e: Event):void
		{
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

		function mHide(e: TimerEvent)
		{
			MouseHide.mouseDownHandler();
		}
		public function resetGame()
		{
			for(var i:int = 0; i < numChildren;i++)
			{
				removeChildAt(i);
			}
		}

	}

}