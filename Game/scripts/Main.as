package scripts  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.DisplayObject;
	
	import thirdparty.CollisionTest;
	import scripts.GameObject;
	import scripts.Ship;
	import scripts.XmlLoader;
	
	public class Main extends MovieClip {
		private var shipArray = new XmlLoader();
		
		public function Main() {
		
		}
		/*
		
		private var colTester:CollisionTest;
		private var gameObject = new Array();
		public function Main() {
			// constructor code
			colTester = new CollisionTest();
			for(var i:int = 0;i < numChildren; i++){
				var go:GameObject = (GameObject)(getChildAt(i));
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
			var go:GameObject = (GameObject)(child);
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
		} */
	}
	
}
