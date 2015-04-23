package scripts  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	//Laster in alle third party Scripts
	import thirdparty.CollisionTest;
	import scripts.GameObject;
	import scripts.Ship;
	import scripts.XmlLoader;
	import scripts.MouseHide;
	
	public class Main extends MovieClip {
	
		public var debug = true;
		
		private var colTester:CollisionTest;
		private var gameObject;
		private var xmlLoader:XmlLoader;
		private var imageLoader:ImageLoader;
		static var main:Main;
		
		static function getMain():Main
		{
			return main;
		}
		public function Main() {
			// constructor code
			if(main == null)
				main = this;
			
			xmlLoader = new XmlLoader("content/content.xml");
			imageLoader = new ImageLoader();
			timerMouseHide.addEventListener(TimerEvent.TIMER_COMPLETE, mHide);
			stage.addEventListener(Event.ENTER_FRAME, checkMovement);
			colTester = new CollisionTest();
			for(var i:int = 0;i < numChildren; i++){
				var go:GameObject = getChildAt(i) as GameObject;
				if(go != null)
				{
					gameObject.push(go);
				}
			}
			//addEventListener(Event.ENTER_FRAME,frameEnter);
		}
		
		//a Override for the addChild function so all GameObjects gets added to a seperate list that cheks for collision.
		//
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			var go:GameObject = child as GameObject;
			if(go != null)
			{
				gameObject.push(go);
			}
			return super.addChild(child);
		}
		
		public function frameEnter(e:Event){
			for(var i:int = 0;i < gameObject.length; i++){
				for(var j:int = i+1;j < gameObject.length; j++)
				{
					if(colTester.complex(gameObject[i],gameObject[j]))
					{
						gameObject[i].onCollision(gameObject[j]);
						gameObject[j].onCollision(gameObject[i]);
					}
				}
			}
		} 
		public function getXMLLoader():XmlLoader{
			return xmlLoader;
		}
		public function getImageLoader():ImageLoader{
			return imageLoader;
		}
			// HER KOMMER NÅ MOUSE FUNKSJONEN SOM SKJULER DEN AUTOMATISK
			var switcher:int = 0;
			var posX1:Number = stage.mouseX;
			var posY1:Number = stage.mouseY;
			var posX2:Number = stage.mouseX;
			var posY2:Number = stage.mouseY;
			var timerMouseHide:Timer = new Timer(2000, 1);

			function checkMovement(e:Event):void
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

			function mHide (e:TimerEvent){
			MouseHide.mouseDownHandler();
			}
		
	}
	
}
