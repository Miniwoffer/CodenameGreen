package scripts {
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	
	public class Explosion extends MovieClip {
		var image:Bitmap;
		var deathTimer:Timer;
		public function Explosion(weaponId:int,scale:Number) {
			scaleY = scale;
			scaleX = scale;
			var xmlData:XMLList = Main.getMain().getXMLLoader().getXmlData().weapons.weapon[weaponId].bullet.explosion;
			image = Main.getMain().getImageLoader().getImage(xmlData.imgnum);;
			addChild(image);
			Main.getMain().addChild(this);
			deathTimer = new Timer(xmlData.lifetime,1);
			deathTimer.addEventListener(TimerEvent.TIMER_COMPLETE,destroy);
			deathTimer.start();
			addEventListener(Event.ENTER_FRAME,update);
			// constructor code
			
		}
		public function update(e:Event)
		{
			scaleX = scaleX*0.8;
			scaleY = scaleX;
			rotation = Math.random()*360;
		}
		public function destroy(e:Event)
		{
			parent.removeChild(this);
		}
		

	}
	
}
