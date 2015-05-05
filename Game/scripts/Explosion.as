package scripts {
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	//Explosion.as er en klasse som tilføyer lyder og bilder når en eksplosjon skjer, ettersom hva som sprenger (weaponId)
	
	public class Explosion extends MovieClip {
		var image:Bitmap;
		var deathTimer:Timer;
		public function Explosion(weaponId:int,scale:Number) {
			scaleY = scale;
			scaleX = scale;
			var xmlData:XMLList = Main.getMain().getXMLLoader().getXmlData().weapons.weapon[weaponId].bullet.explosion;
			image = Main.getMain().getImageLoader().getImage(xmlData.imgnum);
			var sound:Sound = Main.getMain().getSoundLoader().getSound(xmlData.soundnum);
			var soundTrans:SoundTransform = new SoundTransform(xmlData.soundvolum);
			sound.play(0,0,soundTrans);
			addChild(image);
			Main.getMain().addChild(this);
			deathTimer = new Timer(xmlData.lifetime,1);
			deathTimer.addEventListener(TimerEvent.TIMER_COMPLETE,destroy);
			deathTimer.start();
			addEventListener(Event.ENTER_FRAME,update);
			// constructor code
			
		}
		
		//Gjør Skaleringen mindre
		public function update(e:Event)
		{
			scaleX = scaleX*0.8;
			scaleY = scaleX;
			rotation = Math.random()*360;
		}
		
		//Ødelegger explosjonen
		public function destroy(e:Event)
		{
			parent.removeChild(this);
		}
		

	}
	
}
