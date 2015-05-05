package scripts {
	
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import scripts.Main;
	
	
	public class MusicScript {
		
		//Lager variabler, laster inn de tre sangene

		static public var introSound:Sound = new Sound(new URLRequest("content/sound/Relaxing.mp3"));
		static public var idleSound:Sound = new Sound(new URLRequest("content/sound/Newdawn.mp3"));
		static public var epicSound:Sound = new Sound(new URLRequest("content/sound/Epic.mp3"));
		
		
		static public var musicChannel:SoundChannel;
		static public var lastPosition:Number = 0;
		static public var currentTrack:Sound = introSound;
		
		//Setter play/pause knappen til riktig stilling i hud'en
		Main.getMain().getHud().soundMC.playButton.visible = false;
		Main.getMain().getHud().soundMC.pauseButton.visible = true;
		Main.getMain().getHud().soundMC.pauseButton.addEventListener(MouseEvent.CLICK, pause);
		Main.getMain().getHud().soundMC.playButton.addEventListener(MouseEvent.CLICK, resume);

		
		public function MusicScript() {
			
		}
		
		//Funksjon for å hente currentTrack
		static public function getCurrentTrack ():Sound{
			return currentTrack;
		}
		
		//Denne setter currentTrack, altså sangen som spilles. Den resetter også lastposition.
		static public function setCurrentTrack (soundTrack:Sound){
			musicChannel.stop();
			currentTrack = soundTrack;
			lastPosition = 0;
			if (Main.getMain().getHud().soundMC.pauseButton.visible){
				start(null);
			}
		}

		//Funksjonen som starter musikken
		static function start (e:Event){
			musicChannel = currentTrack.play();
			musicChannel.addEventListener(Event.SOUND_COMPLETE, start);
		}

		//Funksjonen som pauser musikken
		static public function pause(e:MouseEvent){
			lastPosition = musicChannel.position;
			musicChannel.stop();
			Main.getMain().getHud().soundMC.playButton.visible = true;
			Main.getMain().getHud().soundMC.pauseButton.visible = false;
		}
		
		//funksjonen som starter musikken igjen på riktig punkt ved help av lastPosition 
		static public function resume (e:MouseEvent){
			musicChannel = currentTrack.play(lastPosition);
			Main.getMain().getHud().soundMC.playButton.visible = false;
			Main.getMain().getHud().soundMC.pauseButton.visible = true;
			musicChannel.addEventListener(Event.SOUND_COMPLETE, start);
		}
		 
	}
	
}
